//
//  CreateProfileViewController.swift
//  D-Book
//
//  Created by 강민석 on 2020/11/07.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa

class CreateProfileViewController: BaseViewController, StoryboardSceneBased {
    
    static let sceneStoryboard = R.storyboard.createProfile()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
    }

}