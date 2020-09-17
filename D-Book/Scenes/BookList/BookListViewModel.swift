//
//  BookListViewModel.swift
//  D-Book
//
//  Created by 강민석 on 2020/09/16.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import RxSwift
import RxCocoa

class BookListViewModel {
    
    let disposeBag = DisposeBag()
    let searchText = BehaviorRelay(value: "")
    
    struct Input {
        let searchButton: Driver<Void>
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        
        input.searchButton
            .drive(onNext: { [weak self] in
                self?.searchBook()
            }).disposed(by: disposeBag)
        
        return Output()
    }
    
    func searchBook() {
        
    }
    
    
}
