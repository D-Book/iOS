//
//  LoginViewController.swift
//  D-Book
//
//  Created by 강민석 on 2020/07/24.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        configureCallback()
    }
}

// MARK: - BindViewModel
extension LoginViewController {
    func bindViewModel() {
        let input = LoginViewModel.Input(loginTrigger: loginButton.rx.tap.asDriver())
        let output = viewModel.transform(input: input)
        
        emailField.rx.text.orEmpty
            .bind(to: viewModel.id)
            .disposed(by: disposeBag)
        
        passwordField.rx.text.orEmpty
            .bind(to: viewModel.pw)
            .disposed(by: disposeBag)
        
        output.loginButtonEnabled
            .drive(loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}

// MARK: - ConfigureCallback
extension LoginViewController {
    func configureCallback() {
        viewModel.isLoading
            .bind { [weak self] isLoading in
                if isLoading { self?.startIndicatingActivity() }
        }.disposed(by: disposeBag)
        
        viewModel.isSuccess
            .bind { isSuccess in
                if isSuccess {
                    self.stopIndicatingActivity()
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                    (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(mainTabBarController)
                }
        }.disposed(by: disposeBag)
        
        viewModel.errorMsg.bind { errorMessage in
            if errorMessage != "" {
                self.stopIndicatingActivity()
                self.warningAlert(title: "오류가 발생했습니다.", message: errorMessage)
            }
        }.disposed(by: disposeBag)
    }
}
