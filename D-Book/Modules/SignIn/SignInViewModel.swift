//
//  SignInViewModel.swift
//  D-Book
//
//  Created by 강민석 on 2020/11/07.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import RxSwift
import RxCocoa

class SignInViewModel: BaseViewModel {
    
    let email = BehaviorRelay(value: "")
    let password = BehaviorRelay(value: "")
    
    // MARK: - Struct
    struct Input {
        let signInSelection: Observable<Void>
        let signUpSelection: Driver<Void>
    }

    struct Output {
        let signInButtonEnabled: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        
        input.signInSelection.flatMapLatest { [weak self] () -> Observable<SignInResponse> in
            guard let self = self else  { return Observable.just(SignInResponse()) }
            
            let email = self.email.value
            let password = self.password.value
            return self.service.signIn(email: email, password: password)
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
        
        input.signUpSelection
            .drive(onNext: { [weak self] in
                self?.steps.accept(IntroStep.signUpIsRequired)
            }).disposed(by: rx.disposeBag)
        
        let signInButtonEnabled = BehaviorRelay.combineLatest(email, password, self.loading.asObservable()) {
            return !$0.isEmpty && !$1.isEmpty && !$2
        }.asDriver(onErrorJustReturn: false)
        
        return Output(signInButtonEnabled: signInButtonEnabled)
    }
    
}
