//
//  User.swift
//  D-Book
//
//  Created by 강민석 on 2020/08/19.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var username: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var profileImage: String = ""
    @objc dynamic var libraryImage: String = ""
    @objc dynamic var libraryName: String = ""
    
    required convenience init(username: String, email: String, profileImage: String, libraryImage: String, libraryName: String) {
        self.init()
        
        self.username = username
        self.email = email
        self.profileImage = profileImage
        self.libraryName = libraryImage
        self.libraryName = libraryName
    }
}
