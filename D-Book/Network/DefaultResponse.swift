//
//  DefaultResponse.swift
//  D-Book
//
//  Created by 강민석 on 2020/08/26.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import Foundation

struct DefaultResponse: ResponseProtocol {
    var status: Int
    var message: String
    
    enum CodingKeys : String, CodingKey {
        case status
        case message
    }
}
