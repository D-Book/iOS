//
//  SignUpViewModel.swift
//  D-Book
//
//  Created by 강민석 on 2020/11/07.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import RxSwift
import RxCocoa

class SignUpViewModel: BaseViewModel {
    
    let email = BehaviorRelay(value: "")
    let password = BehaviorRelay(value: "")
    
    let emailValid = BehaviorRelay(value: false)
    let passwordValid = BehaviorRelay(value: false)
    
    // MARK: - Struct
    struct Input {
        let nextButtonSelection: Driver<Void>
        let signInButtonSelection: Driver<Void>
        let emailEvents: Observable<Bool>
        let passwordEvents: Observable<Bool>
    }
    
    struct Output {
        let nextButtonEnabled: Driver<Bool>
        let emailValidation: Driver<UIImage>
        let passwordValidation: Driver<UIImage>
    }
    
    // MARK: - Regular Expression
    func validateEmail(_ string: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return string.range(of: emailRegEx, options: .regularExpression) != nil
    }
    
    func validatePassword(_ string: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: string)
    }
}

extension SignUpViewModel {
    func transform(input: Input) -> Output {
        
        // MARK: - Input
        input.nextButtonSelection
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.steps.accept(IntroStep.createProfileIsRequired(email: self.email.value,
                                                                    password: self.password.value))
            }).disposed(by: rx.disposeBag)
        
        input.signInButtonSelection
            .drive(onNext: { [weak self] in
                self?.steps.accept(IntroStep.dismissSignUpIsRequired)
            }).disposed(by: rx.disposeBag)
        
        // MARK: - Button Status
        let buttonStatus = BehaviorRelay.combineLatest(self.emailValid, self.passwordValid) {
            return $0 && $1
        }.asDriver(onErrorJustReturn: false)
        
        // MARK: - Valid Check
        let isEmailValid = email
            .throttle(RxTimeInterval.milliseconds(100), scheduler: MainScheduler.instance)
            .map { [weak self] text -> Bool in
                guard let isValid = self?.validateEmail(text) else { return false }
                return !text.isEmpty && isValid
            }.distinctUntilChanged()
        
        let isPasswordValid = password
            .throttle(RxTimeInterval.milliseconds(100), scheduler: MainScheduler.instance)
            .map { [weak self] text -> Bool in
                guard let isValid = self?.validatePassword(text) else { return false }
                return !text.isEmpty && isValid
            }.distinctUntilChanged()
        
        // MARK: - Validation Observable
        let emailValidation = Observable.combineLatest(isEmailValid, input.emailEvents).flatMap { [weak self] (isValid: Bool, editingDidEnd: Bool) -> Observable<UIImage> in
            if isValid {
                self?.emailValid.accept(true)
                return Observable.from(optional: R.image.success())
            } else if editingDidEnd {
                self?.emailValid.accept(false)
                return Observable.from(optional: R.image.fail())
            } else {
                self?.emailValid.accept(false)
                return .empty()
            }
        }.distinctUntilChanged()

        let passwordValidation = Observable.combineLatest(isPasswordValid, input.passwordEvents).flatMap { [weak self] (isValid: Bool, editingDidEnd: Bool) -> Observable<UIImage> in
            if isValid {
                self?.passwordValid.accept(true)
                return Observable.from(optional: R.image.success())
            } else if editingDidEnd {
                self?.passwordValid.accept(false)
                return Observable.from(optional: R.image.fail())
            } else {
                self?.passwordValid.accept(false)
                return .empty()
            }
        }.distinctUntilChanged()
        
        return Output(nextButtonEnabled: buttonStatus,
                      emailValidation: emailValidation.asDriver(onErrorJustReturn: UIImage()),
                      passwordValidation: passwordValidation.asDriver(onErrorJustReturn: UIImage()))
    }
}
