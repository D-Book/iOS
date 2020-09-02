//
//  PostLogin.swift
//  D-Book
//
//  Created by 강민석 on 2020/07/25.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import Foundation

struct PostLogin: ResponseProtocol {
    var status: Int
    var message: String
    var token: String
    var username: String
    var email: String
    var profileImage: String
    var libraryImage: String
    var libraryName: String
    
    enum CodingKeys : String, CodingKey {
        case status
        case message
        case token
        case username
        case email
        case profileImage = "profile_image"
        case libraryImage = "library_image"
        case libraryName = "library_name"
    }
}
