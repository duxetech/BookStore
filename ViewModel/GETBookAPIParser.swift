//
//  GETBookAPIParser.swift
//  BookStore
//
//  Created by Karthik on 10/08/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

import Foundation

class GETBookAPIParser {
    
    let api = API()
    
    var books : [Book]? = [] {
        didSet {

            reload()
        }
    }
    
    var reload = { ()->() in }
    
    func getBooks() {
        api.getBooksData {
            data in
            self.books = data
        }
    }
}

