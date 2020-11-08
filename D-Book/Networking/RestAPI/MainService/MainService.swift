//
//  MainService.swift
//  D-Book
//
//  Created by 강민석 on 2020/10/21.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import CryptoSwift

final class MainService: BaseService<MainAPI> {
    
    func signIn(email: String, password: String) -> Single<SignInResponse> {
        requestObject(.signIn(email: email, password: password.sha256()), type: SignInResponse.self)
    }
    
    func signUp(username: String, email: String, password: String, profileImage: UIImage?) -> Single<SignInResponse> {
        requestObject(.signUp(username: username,
                              email: email,
                              password: password.sha256(),
                              profileImage: profileImage),
                      type: SignInResponse.self)
    }
    
    func bookList() {
        
    }
    
    func bookUpload(title: String, author: String, category: String, coverImage: UIImage, bookFile: Data, description: String?, publisher: String) {
        
    }
    
    func bookEdit(bookId: Int, title: String, author: String, category: String, coverImage: UIImage, bookFile: Data, description: String?, publisher: String) {
        
    }
    
    func bookDelete(bookId: Int) {
        
    }
    
    func addMyLibrary(bookId: Int) {
        
    }
    
    func myLibrary() {
        
    }
    
    func myUploadedBook() {
        
    }
    
}

extension MainService {
    private func requestWithoutMapping(_ target: MainAPI) -> Single<Void> {
        return request(target)
            .map { _ in }
    }
    
    private func requestObject<T: Codable>(_ target: MainAPI, type: T.Type) -> Single<T> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return request(target)
            .map(T.self, using: decoder)
    }
    
    private func requestArray<T: Codable>(_ target: MainAPI, type: T.Type) -> Single<[T]> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return request(target)
            .map([T].self, using: decoder)
    }
}
