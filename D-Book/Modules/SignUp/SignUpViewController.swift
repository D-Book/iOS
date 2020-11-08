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
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
    }
}
