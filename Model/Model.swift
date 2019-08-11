//
//  Model.swift
//  BookStore
//
//  Created by Karthik on 08/08/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

import Foundation

struct User : Codable {
    let username : String?
    let password : String?
}


// MARK: - WelcomeElement
struct Book: Codable {
    let id, isbn, title, author: String
    let publisher: String
    let image: String
    let v: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case isbn, title, author, publisher, image
        case v = "__v"
    }
}

