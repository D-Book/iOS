//
//  PostLoginRequest.swift
//  D-Book
//
//  Created by 강민석 on 2020/07/26.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import Foundation

struct PostLoginRequest: Encodable {
    var email: String
    var password: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case password
    }
}
