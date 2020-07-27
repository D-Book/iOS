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
    
    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
    }
    

}

extension LoginViewController {
    
    func bindViewModel() {
        let input = LoginViewModel.Input(trigger: loginButton.rx.tap.asObservable())
        let output = viewModel.transform(input: input)
        
        output.response
            .drive(onNext: { response in
                print(response.message)
            }).disposed(by: disposeBag)
    }
    
}
