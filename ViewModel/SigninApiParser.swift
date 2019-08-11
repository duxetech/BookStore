//
//  Parser.swift
//  BookStore
//
//  Created by Karthik on 09/08/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

import Foundation


class SigninApiParser {
    
    let api = API()
    var token : String?
    var loggedIn : Bool? {
        didSet {
            reload()
        }
    }
   
    
    
    var reload = { ()->() in }
    
    func signinCheck(name : String, pass : String){
        api.signinResponse(user: name, pass: pass) {
            data in
            if data == nil {
                print("no data")
                return }
            
            if data!["success"] as? Bool == false {
                self.loggedIn = false
                print("login failed")
                return
            }
            if data!["success"] as? Bool == true {
                self.loggedIn = true
                print("logged in")
                self.token = data!["token"] as? String
                Constants.token = self.token!
            }
            
        }
    }
    
    
    
    
    
    func parseBook(){
        
    }
}
