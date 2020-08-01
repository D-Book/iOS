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
        let trigger: Observable<Void>
    }
    
    struct Output {
        let response: Driver<PostLogin.Response>
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
        
        let response = input.trigger
            .flatMapLatest {
                self.networkClient.postRequest(PostLogin.Response.self, endpoint: "", param: self.loginRequest)
            }
            
        response
            .subscribe(
                onNext : { response in
//                    KeychainService.username = self.emailIdViewModel.data.value
//                    KeychainService.password =  self.passwordViewModel.data.value
//
//                    AuthController.signIn(token: response.data!.token!, refreshToken: response.data!.refreshToken!)
                        
                    self.isLoading.accept(false)
                    self.isSuccess.accept(true)
                },
                onError : { error in
                    self.isLoading.accept(false)
                    self.errorMsg.accept(error.localizedDescription)
                }
            ).disposed(by : disposeBag)
            
        return Output(response: response.asDriver(onErrorJustReturn: .init()))
    }
    
    
}
