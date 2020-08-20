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
    
    struct Input {
        let loginTrigger: Observable<Void>
    }
    
    struct Output {
        let loginButtonEnabled: Driver<Bool>
    }
    
    let disposeBag = DisposeBag()
    let isSuccess = BehaviorRelay(value: false)
    let isLoading = BehaviorRelay(value: false)
    let errorMsg = BehaviorRelay(value: "")
    
    let networkClient = NetworkClient()
    var loginRequest = PostLoginRequest()
    
    let id = BehaviorRelay(value: "")
    let pw = BehaviorRelay(value: "")

    func transform(input: Input) -> Output {
        
        loginRequest.id = self.id.value
        loginRequest.pw = self.pw.value
        
        let response = input.loginTrigger
            .flatMapLatest {
                self.networkClient.postRequest(PostLogin.self, endpoint: "", param: self.loginRequest)
            }
            
        response
            .subscribe(
                onNext: { response in
                    
                    UserDefaults.standard.set(true, forKey: "loginState")
                    TokenManager.shared.token = response.accessToken
                    
                    response.email
                    
                    self.isLoading.accept(false)
                    self.isSuccess.accept(true)
                },
                onError: { error in
                    self.isLoading.accept(false)
                    self.errorMsg.accept(error.localizedDescription)
                }
            ).disposed(by : disposeBag)
        
        let loginButtonEnabled = BehaviorRelay.combineLatest(id, pw, self.isLoading.asObservable()) {
            return !$0.isEmpty && !$1.isEmpty && !$2
        }.asDriver(onErrorJustReturn: false)
            
        return Output(loginButtonEnabled: loginButtonEnabled)
    }
    
    
}
