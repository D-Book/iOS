//
//  PostLogin.swift
//  D-Book
//
//  Created by 강민석 on 2020/07/25.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import Foundation

struct PostLogin: ResponseProtocol {
    var status: Int?
    var message: String?
    var token: String?
    var email: String?
    
    enum CodingKeys : String, CodingKey {
        case status
        case message
        case token
        case email
    }
}
