//
//  PostLogin.swift
//  D-Book
//
//  Created by 강민석 on 2020/07/25.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import Foundation

struct PostLogin {
    
    class Response : ResponseProtocol {
        var status: Int?
        var message: String?
        var data: Data?
        
        enum ResponseKey : String, CodingKey{
            case status
            case message
            case data
        }
        
        required convenience init(from decoder: Decoder) throws {
            self.init()
            
            let container = try decoder.container(keyedBy: ResponseKey.self)
            
            self.status = try container.decode(Int.self, forKey: .status)
            self.message = try container.decodeIfPresent(String.self, forKey: .message)
            self.data = try container.decodeIfPresent(Data.self, forKey: .data)
            
        }
    }
    
    class Data : Decodable{
        var token: String?
        
        enum DataKey : String, CodingKey{
            case token
        }
        
        required convenience init(from decoder: Decoder) throws {
            self.init()
            
            let container = try decoder.container(keyedBy: DataKey.self)
            
            self.token = try container.decodeIfPresent(String.self, forKey: .token)
        }
    }
}
