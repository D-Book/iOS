//
//  SignUpViewModel.swift
//  D-Book
//
//  Created by 강민석 on 2020/08/26.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SignUpViewModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    let isSuccess = BehaviorRelay(value: false)
    let isLoading = BehaviorRelay(value: false)
    let errorMsg = BehaviorRelay(value: "")
    
    let networkClient = NetworkClient.shared
    
    let email = BehaviorRelay(value: "")
    let password = BehaviorRelay(value: "")
    
    struct Input {
        let nextTrigger: Driver<Void>
    }
    
    struct Output {
        let nextButtonEnabled: Driver<Bool>
    }
    
}

// MARK: - Transform
extension SignUpViewModel {
    func transform(input: Input) -> Output {
        input.nextTrigger
            .drive(onNext: { [weak self] in
                self?.postSignUpRequest()
            }).disposed(by: disposeBag)
        
        let signUpButtonEnabled = BehaviorRelay.combineLatest(email, password, isLoading.asObservable()) {
            return !$0.isEmpty && !$1.isEmpty && !$2
        }.asDriver(onErrorJustReturn: false)
        
        return Output(nextButtonEnabled: signUpButtonEnabled)
    }
}

// MARK: - SignUpRequest
extension SignUpViewModel {
    func postSignUpRequest() {
        
        let signUpRequest = PostLoginRequest(email: email.value, password: password.value)
        
        self.isLoading.accept(true)
        self.networkClient.postRequest(DefaultResponse.self, endpoint: "users/signup", param: signUpRequest)
        .subscribe(
            onNext: { [weak self] response in
                self?.isLoading.accept(false)
                self?.isSuccess.accept(true)
            },
            onError: { [weak self] error in
                guard let error = error as? DefaultResponse else { return }
                self?.errorMsg.accept(error.message)
            }
        ).disposed(by: disposeBag)
    }
}
