//
//  Book.swift
//  D-Book
//
//  Created by 강민석 on 2020/11/07.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import Foundation

struct Book: Codable {
    var id: Int
    var category: String
    var title: String
    var author: String
    var bookFileUrl: URL
    var coverImageUrl: URL
    var description: String
    var uploaderId: Int
    var publisher: String
    var published: Date
    
    private enum CodingKeys: String, CodingKey {
        case id
        case category
        case title
        case author
        case bookFileUrl = "book_file"
        case coverImageUrl = "cover_image"
        case description
        case uploaderId = "uploader_id"
        case publisher
        case published
    }
}
