//
//  LoginViewModel.swift
//  D-Book
//
//  Created by 강민석 on 2020/07/24.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    let isSuccess = BehaviorRelay(value: false)
    let isLoading = BehaviorRelay(value: false)
    let errorMsg = BehaviorRelay(value: "")
    
    let networkClient = NetworkClient.shared
    
    let id = BehaviorRelay(value: "")
    let pw = BehaviorRelay(value: "")
    
    struct Input {
        let loginTrigger: Driver<Void>
    }
    
    struct Output {
        let loginButtonEnabled: Driver<Bool>
    }
}

// MARK: - Transform
extension LoginViewModel {
    func transform(input: Input) -> Output {
        input.loginTrigger
            .drive(onNext: { [weak self] in
                self?.postLoginRequest()
            }).disposed(by: disposeBag)
        
        let loginButtonEnabled = BehaviorRelay.combineLatest(id, pw, self.isLoading.asObservable()) {
            return !$0.isEmpty && !$1.isEmpty && !$2
        }.asDriver(onErrorJustReturn: false)
        
        return Output(loginButtonEnabled: loginButtonEnabled)
    }
}

// MARK: - LoginRequest
extension LoginViewModel {
    func postLoginRequest() {
            let loginRequest = PostLoginRequest(email: self.id.value, password: self.pw.value)
            
            self.isLoading.accept(true)
            self.networkClient.postRequest(PostLogin.self, endpoint: "/users/logins", param: loginRequest)
                .subscribe(
                    onNext: { response in
                        UserDefaults.standard.set(true, forKey: "loginState")
                        
                        TokenManager.shared.token = response.token
                        
                        let userData = User(username: response.username,
                                        email: response.email,
                                        profileImage: response.profileImage,
                                        libraryImage: response.libraryImage,
                                        libraryName: response.libraryName)
                        
                        DatabaseManager.shared.saveUser(userData)
                        
                        self.isLoading.accept(false)
                        self.isSuccess.accept(true)
                    },
                    onError: { error in
                        self.isLoading.accept(false)
//                        guard let error = error as? PostLogin else { return }
                        self.errorMsg.accept(error.localizedDescription)
                    }
                ).disposed(by : disposeBag)
        }
}
