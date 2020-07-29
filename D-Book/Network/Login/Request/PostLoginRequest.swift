//
//  PostLoginRequest.swift
//  D-Book
//
//  Created by 강민석 on 2020/07/26.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import Foundation

class PostLoginRequest: Encodable{
    var id : String = ""
    var pw : String = ""
    
    convenience init(id : String, pw : String) {
        self.init()
        self.id = id
        self.pw = pw
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case pw
    }
}
