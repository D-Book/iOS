//
//  SignUpViewController.swift
//  D-Book
//
//  Created by 강민석 on 2020/11/07.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa

class SignUpViewController: BaseViewController, StoryboardSceneBased {
    
    static let sceneStoryboard = R.storyboard.signUp()
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var emailValidImage: UIImageView!
    @IBOutlet weak var passwordValidImage: UIImageView!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        guard let viewModel = viewModel as? SignUpViewModel else { fatalError("ViewModel: \(self.viewModel!) Casting Error") }
        
        let emailControlEvents: Observable<Bool> = Observable.merge([
            emailField.rx.controlEvent(.editingDidBegin).map { true },
            emailField.rx.controlEvent(.editingDidEnd).map { false }
        ])

        let passwordControlEvents: Observable<Bool> = Observable.merge([
            passwordField.rx.controlEvent(.editingDidBegin).map { true },
            passwordField.rx.controlEvent(.editingDidEnd).map { false }
        ])
        
        let input = SignUpViewModel.Input(nextButtonSelection: nextButton.rx.tap.asDriver(),
                                          signInButtonSelection: signInButton.rx.tap.asDriver(),
                                          emailEvents: emailControlEvents,
                                          passwordEvents: passwordControlEvents)
        let output = viewModel.transform(input: input)
        
        emailField.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: rx.disposeBag)

        passwordField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: rx.disposeBag)

        output.nextButtonEnabled
            .drive(nextButton.rx.isEnabled)
            .disposed(by: rx.disposeBag)

        output.emailValidation
            .drive(self.emailValidImage.rx.image)
            .disposed(by: rx.disposeBag)

        output.passwordValidation
            .drive(self.passwordValidImage.rx.image)
            .disposed(by: rx.disposeBag)
    }
}
