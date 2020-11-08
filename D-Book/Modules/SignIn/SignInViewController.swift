//
//  SignInViewController.swift
//  D-Book
//
//  Created by 강민석 on 2020/11/07.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa

class SignInViewController: BaseViewController, StoryboardSceneBased {

    static let sceneStoryboard = R.storyboard.signIn()
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        guard let viewModel = self.viewModel as? SignInViewModel else { fatalError("ViewModel: \(self.viewModel!) Casting Error") }
        
        let input = SignInViewModel.Input(signInSelection: signInButton.rx.tap.asObservable(),
                                          signUpSelection: signUpButton.rx.tap.asDriver())
        let output = viewModel.transform(input: input)
        
        output.signInButtonEnabled
            .drive(self.signInButton.rx.isEnabled)
            .disposed(by: rx.disposeBag)
    }
}
