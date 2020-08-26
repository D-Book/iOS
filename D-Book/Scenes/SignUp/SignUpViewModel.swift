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
    let email = BehaviorRelay(value: "")
    let password = BehaviorRelay(value: "")
    let networkClient = NetworkClient()
    
    struct Input {
        let nextTrigger: Observable<Void>
    }
    
    struct Output {
        let nextButtonEnabled: Driver<Bool>
    }
    
}

// MARK: - Transform
extension SignUpViewModel {
    func transform(input: Input) -> Output {
        
        input.nextTrigger
            .flatMapLatest {
                networkClient.postRequest(DefaultResponse.self, endpoint: "users/sendEmail", param: ["email": self.email.value])
        }.subscribe(
            onNext: { response in
                print(response.status)
            },
            onError: {
                
            }
        ).disposed(by: disposeBag)
        
        
        
    }
}
