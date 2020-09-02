//
//  SignUpViewController.swift
//  D-Book
//
//  Created by 강민석 on 2020/08/26.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var dismissToLogin: UIButton!
    @IBOutlet weak var completeButton: UIButton!
    
    let disposeBag = DisposeBag()
    let viewModel = SignUpViewModel()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        configureCallback()
    }
}

// MARK: - BindViewModel
extension SignUpViewController {
    func bindViewModel() {
        
        let input = SignUpViewModel.Input(nextTrigger: completeButton.rx.tap.asDriver())
        let output = viewModel.transform(input: input)
        
        dismissToLogin.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        emailField.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        passwordField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        output.nextButtonEnabled
            .drive(completeButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}

// MARK: - ConfigureCallback
extension SignUpViewController {
    func configureCallback() {
        viewModel.isLoading
            .bind { [weak self] isLoading in
                if isLoading { self?.startIndicatingActivity() }
        }.disposed(by: disposeBag)
        
        viewModel.isSuccess
            .bind { isSuccess in
                if isSuccess {
                    self.stopIndicatingActivity()
                    
                    self.navigationController?.popToRootViewController(animated: true)
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
