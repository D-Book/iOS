//
//  Network.swift
//  D-Book
//
//  Created by 강민석 on 2020/07/24.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import RxAlamofire

class NetworkClient {
    
    var BASE_URL = "http://10.80.162.210:8080/"
    
    func postRequest<T: ResponseProtocol>(_ type:  T.Type, endpoint: String, param: Encodable) -> Observable<T> {
        
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        
        return RxAlamofire.request(.post, self.BASE_URL + endpoint, parameters: param.dictionary, encoding: JSONEncoding.default, headers: header)
            .responseJSON()
            .map { response -> T in
                if let data = response.data {
                    let decodeResponse = try JSONDecoder().decode(T.self, from: data)
                    
                    print(decodeResponse.status)
                    if decodeResponse.status == 200 {
                        return decodeResponse
                    }
//                    else if decodeResponse.status == 410 {
//                        // renewal token
//                    }
                    else {
                        throw NetworkError.errorStatusCode(statusCode: decodeResponse.status ?? 0)
                    }
                    
                } else {
                    throw NetworkError.notConnected
                }
        }
        
    }
    
    //    func postRequest<T: ResponseProtocol>(_ type: T.Type, endpoint: String, param: Encodable) -> Observable<T> {
    //        return Observable.create { _ -> Disposable in
    //            RxAlamofire.request(.post, self.BASE_URL + endpoint, parameters: param).responseJSON()
    //                .subscribe(onNext: { response in
    //                    return response
    //                })
    //        }
    //
    //    }
    
}

public enum NetworkError: Error {
    case errorStatusCode(statusCode: Int)
    case notConnected
    case cancelled
    case urlGeneration
    case requestError(Error?)
}

extension NetworkError {
    var isNotFoundError: Bool { return hasCodeError(404) }
    
    func hasCodeError(_ codeError: Int) -> Bool {
        switch self {
        case let .errorStatusCode(code):
            return code == codeError
        default: return false
        }
    }
}

extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
}
