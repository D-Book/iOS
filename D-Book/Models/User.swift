//
//  User.swift
//  D-Book
//
//  Created by 강민석 on 2020/08/19.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object, Codable {
    @objc dynamic var id: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var profileImage: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case email
        case password
        case profileImage = "profile_image"
    }
}
