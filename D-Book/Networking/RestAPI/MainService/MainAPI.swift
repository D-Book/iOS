//
//  MainAPI.swift
//  D-Book
//
//  Created by 강민석 on 2020/10/21.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import Foundation
import RxSwift
import Moya

enum MainAPI {
    
    // MARK: - Authentication is not required
    case signIn(email: String, password: String)
    case signUp(username: String, email: String, password: String, profileImage: UIImage?)
    
    case bookList
    
    // MARK: - Authentication is required
    case bookUpload(title: String, author: String, category: String, coverImage: UIImage, bookFile: Data, description: String?, publisher: String)
    case bookEdit(bookId: Int, title: String, author: String, category: String, coverImage: UIImage, bookFile: Data, description: String?, publisher: String)
    case bookDelete(bookId: Int)
    
    case addMyLibrary(bookId: Int)
    case myLibrary
    
    case myUploadedBook
}

extension MainAPI: BaseAPI {
    var path: String {
        switch self {
        case .signIn:
            return "/user/login"
        case .signUp:
            return "/user/sign-up"
        case .bookUpload:
            return "/book/upload"
        case .bookEdit(let bookId, _, _, _, _, _, _, _),
             .bookDelete(let bookId):
            return "/book/\(bookId)"
        case .bookList:
            return "/booklist"
        case .addMyLibrary:
            return "mylibrary/add"
        case .myLibrary:
            return "mylibrary"
        case .myUploadedBook:
            return "/mylibrary/uploaded"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signIn, .signUp, .bookUpload, .addMyLibrary:
            return .post
        case .bookEdit:
            return .put
        case .bookDelete:
            return .delete
        default:
            return .get
        }
    }
    
    var headers: [String: String]? {
        switch self {
        // None Authentication
        case .signIn, .signUp, .bookList:
            break
        // Authentication
        default:
            return ["Authentication": TokenManager.shared.token!]
        }
        return nil
    }
    
    var task: Task {
        switch self {
        case .signUp(let username, let email, let password, let profileImage):
            var formData = [MultipartFormData]()
            
            formData.append(.init(provider: .data(username.data(using: .utf8)!), name: "username"))
            formData.append(.init(provider: .data(email.data(using: .utf8)!), name: "email"))
            formData.append(.init(provider: .data(password.data(using: .utf8)!), name: "password"))
            
            if let data = profileImage?.jpegData(compressionQuality: 1.0) {
                formData.append(.init(provider: .data(data), name: "profile_image", fileName: "profileImage.jpeg", mimeType: "image/jpeg"))
            }
            
            return .uploadMultipart(formData)
            
        case .bookUpload(let title, let author, let category, let coverImage, let bookFile, let description, let publisher),
             .bookEdit(_, let title, let author, let category, let coverImage, let bookFile, let description, let publisher):
            var formData = [MultipartFormData]()
            
            formData.append(.init(provider: .data(title.data(using: .utf8)!), name: "title"))
            formData.append(.init(provider: .data(author.data(using: .utf8)!), name: "author"))
            formData.append(.init(provider: .data(category.data(using: .utf8)!), name: "category"))
            
            if let description = description {
                formData.append(.init(provider: .data(description.data(using: .utf8)!), name: "description"))
            }
            
            formData.append(.init(provider: .data(publisher.data(using: .utf8)!), name: "category"))
            
            if let data = coverImage.jpegData(compressionQuality: 1.0) {
                formData.append(.init(provider: .data(data), name: "cover_image", fileName: "coverImage.jpeg", mimeType: "image/jpeg"))
            }
            
            formData.append(.init(provider: .data(bookFile), name: "book_file", fileName: "book.epub", mimeType: "application/epub+zip"))
            
            return .uploadMultipart(formData)
        default:
            if let parameters = parameters {
                return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            }
            return .requestPlain
        }
    }
    
    var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        switch self {
        case .signIn(let email, let password):
            params["email"] = email
            params["password"] = password
        case .addMyLibrary(let bookId):
            params["book_id"] = bookId
        default: break
        }
        return params
    }
    
}
