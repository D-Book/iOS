//
//  AuthManager.swift
//  D-Book
//
//  Created by 강민석 on 2020/08/19.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import KeychainAccess

let loggedIn = BehaviorRelay<Bool>(value: false)

class TokenManager {
    
    static let shared = TokenManager()
    
    private init() {}
    
    fileprivate let tokenKey = "TokenKey"
    fileprivate let keychain = Keychain(service: Configs.App.bundleIdentifier)
    
    var token: String? {
        get {
            guard let token = keychain[tokenKey] else { return nil }
            return token
        }
        set {
            if let token = newValue {
                keychain[tokenKey] = token
            }
        }
    }
    
}
