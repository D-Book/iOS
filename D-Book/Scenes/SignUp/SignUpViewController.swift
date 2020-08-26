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
    @IBOutlet weak var nextButton: UIButton!
    
    let disposeBag = DisposeBag()
    let viewModel = SignUpViewModel()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "navigateToEmailCheck", let emailCheckViewController = segue.destination as? EmailCheckViewController {
            EmailCheckViewController.password = self.passwordField.text
        }
    }
}
    
    // MARK: - BindViewModel
    extension SignUpViewController {
        func bindViewModel() {
            
            let input = SignUpViewModel.Input()
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
                .drive(nextButton.rx.isEnabled)
                .disposed(by: disposeBag)
            
            
            
        }
}
