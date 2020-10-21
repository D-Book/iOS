//
//  ErrorResponse.swift
//  D-Book
//
//  Created by 강민석 on 2020/10/21.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import Foundation

struct ErrorResponse: Decodable, Error {
    var code: Int?
    let message: String
}
