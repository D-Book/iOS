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
    }
    
}

extension LoginViewController {
    
    func bindViewModel() {
        let input = LoginViewModel.Input(loginTrigger: loginButton.rx.tap.asObservable())
        let output = viewModel.transform(input: input)
        
        emailField.rx.text.orEmpty
            .bind(to: viewModel.id)
            .disposed(by: disposeBag)
        
        passwordField.rx.text.orEmpty
            .bind(to: viewModel.pw)
            .disposed(by: disposeBag)
        
        output.loginButtonEnabled
            .drive(onNext: { [weak self] isEnabled in
                self?.loginButton.isEnabled = isEnabled
            }).disposed(by: disposeBag)
    }
    
    func configureCallback() {
        
        viewModel.isLoading
            .bind { [weak self] isLoading in
                if isLoading {
                    self?.startIndicatingActivity()
                }
            }.disposed(by: disposeBag)
        
        viewModel.isSuccess
            .bind { isSuccess in
                self.stopIndicatingActivity()
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(mainTabBarController)
            }.disposed(by: disposeBag)
        
        viewModel.errorMsg.bind { errorMessage in
            if errorMessage != "n" {
                self.stopIndicatingActivity()
                self.warningAlert(title: "error", message: errorMessage)
            }
        }.disposed(by: disposeBag)
    }
    
}