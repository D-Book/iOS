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
    let networkClient = NetworkClient()
    
    struct Input {
        let trigger: Observable<Void>
    }
    
    struct Output {
        let response: Driver<Int>
    }
    
    func transform(input: Input) -> Output {
        let cv = BehaviorRelay(value: 0)
        
        input.trigger
            .subscribe(onNext: {
                self.networkClient.postRequest(PostLogin.Response, endpoint: "", param: <#T##Encodable#>)
            }).disposed(by: disposeBag)
        
        return Output(response: cv.asDriver(onErrorJustReturn: 0))
        
    }
    
    
}
