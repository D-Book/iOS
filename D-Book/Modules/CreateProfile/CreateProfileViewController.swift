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
import RxGesture

class CreateProfileViewController: BaseViewController, StoryboardSceneBased {
    
    static let sceneStoryboard = R.storyboard.createProfile()
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var completeButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setProfileImageView()
        bindProfileImage()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        guard let viewModel = viewModel as? CreateProfileViewModel else { fatalError("ViewModel: \(self.viewModel!) Casting Error") }
        
        let nameControlEvents: Observable<Bool> = Observable.merge([
            nameTextField.rx.controlEvent(.editingDidBegin).map { true },
            nameTextField.rx.controlEvent(.editingDidEnd).map { false }
        ])
        
        let input = CreateProfileViewModel.Input(completeSelection: completeButton.rx.tap.asObservable(),
                                                 nameEvents: nameControlEvents)
        let output = viewModel.transform(input: input)
        
        nameTextField.rx.text.orEmpty
            .bind(to: viewModel.username)
            .disposed(by: rx.disposeBag)

        output.completeButtonEnabled
            .drive(completeButton.rx.isEnabled)
            .disposed(by: rx.disposeBag)
    }
}

// MARK: - BindImagePicker
extension CreateProfileViewController {
    func bindProfileImage() {
        guard let viewModel = viewModel as? CreateProfileViewModel else { fatalError("FatalError!") }

        let imagePicker = imagePickerScene(
            on: self,
            modalPresentationStyle: .formSheet,
            modalTransitionStyle: .none
        )

        profileImageView.rx.tapGesture()
            .when(.recognized)
            .flatMapLatest { _ in Observable.create(imagePicker) }
            .compactMap { $0[.originalImage] as? UIImage }
            .bind { image in
                self.profileImageView.image = image
                viewModel.profileImage.accept(image)
            }
            .disposed(by: rx.disposeBag)
    }
}

// MARK: - Configure UI
extension CreateProfileViewController {
    func setProfileImageView() {
        profileImageView.roundCorners(.allCorners, radius: 0.5 * profileImageView.frame.width)
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        profileImageView.clipsToBounds = true

        self.profileImageView.image = R.image.profileImage()
    }
}

