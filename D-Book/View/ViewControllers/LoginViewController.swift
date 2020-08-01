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
        let input = LoginViewModel.Input(trigger: loginButton.rx.tap.asObservable())
        let output = viewModel.transform(input: input)
        
        emailField.rx.text.orEmpty
            .bind(to: viewModel.id)
            .disposed(by: disposeBag)
        
        passwordField.rx.text.orEmpty
            .bind(to: viewModel.pw)
            .disposed(by: disposeBag)
        
        output.response
            .drive(onNext: { _ in
                
            }).disposed(by: disposeBag)
    }
    
    func configureCallback() {
        
        viewModel.isLoading
            .bind { [weak self] isLoading in
                if isLoading {
//                    self?.startIndicating()
                }
            }.disposed(by: disposeBag)
        
        viewModel.isSuccess
            .bind { _ in
                //navigate to main scene
            }.disposed(by: disposeBag)
        
    }
    
}
