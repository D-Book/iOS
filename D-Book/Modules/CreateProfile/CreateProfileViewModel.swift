//
//  CreateProfileViewModel.swift
//  D-Book
//
//  Created by 강민석 on 2020/11/07.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import RxSwift
import RxCocoa

class CreateProfileViewModel: BaseViewModel {
    
    let email: String
    let password: String
    
    let profileImage = BehaviorRelay(value: UIImage())
    let username = BehaviorRelay(value: "")
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    // MARK: - Struct
    struct Input {
        let completeSelection: Observable<Void>
        let nameEvents: Observable<Bool>
    }

    struct Output {
        let completeButtonEnabled: Driver<Bool>
    }
    
    func validateName(_ string: String) -> Bool {
        return string.range(of: "^[가-힣]{2,4}+$", options: .regularExpression) != nil
    }
}

extension CreateProfileViewModel {
    func transform(input: Input) -> Output {
        let buttonStatus = BehaviorRelay(value: false)
        
        input.completeSelection.flatMapLatest { [weak self] () -> Observable<SignInResponse> in
            guard let self = self else  { return Observable.just(SignInResponse()) }
            
            let username = self.username.value
            let profileImage = self.profileImage.value
            let request = self.service.signUp(username: username,
                                              email: self.email,
                                              password: self.password,
                                              profileImage: profileImage)
            return request
                .trackActivity(self.loading)
        }.subscribe(onNext: { (signInResponse) in
            if let user = signInResponse.object?.user, let token = signInResponse.token {
                DatabaseManager.shared.saveUser(user)
                TokenManager.shared.token = token
            }
            loggedIn.accept(true)
        }, onError: { (error) in
            loggedIn.accept(false)
            self.error.onNext(error as! ErrorResponse)
        }).disposed(by: rx.disposeBag)
        
        // MARK: - Valid Check
        let isNameValid = username
            .throttle(RxTimeInterval.milliseconds(100), scheduler: MainScheduler.instance)
            .map { [weak self] text -> Bool in
                guard let isValid = self?.validateName(text) else { return false }
                return !text.isEmpty && isValid
        }.distinctUntilChanged()
        
        // MARK: - Validation Observable
        Observable.combineLatest(isNameValid, input.nameEvents)
            .subscribe(onNext: { (isValid: Bool, editingDidEnd: Bool) in
                if isValid {
                    buttonStatus.accept(true)
                } else if editingDidEnd {
                    buttonStatus.accept(false)
                } else {
                    buttonStatus.accept(false)
                }
            }).disposed(by: rx.disposeBag)
        
        return Output(completeButtonEnabled: buttonStatus.asDriver())
    }
}
