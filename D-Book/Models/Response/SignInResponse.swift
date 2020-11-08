//
//  SignInResponse.swift
//  D-Book
//
//  Created by 강민석 on 2020/11/07.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import Foundation

struct SignInResponse: Codable {
    
    var code: Int?
    var message: String?
    var token: String?
    var object: Object?
    
    struct Object: Codable {
        var user: User
    }
    
    init() {}
    
    private enum CodingKeys: String, CodingKey {
        case code
        case message
        case token
        case object
    }
}
