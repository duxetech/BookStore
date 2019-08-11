//
//  API.swift
//  BookStore
//
//  Created by Karthik on 08/08/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

import Foundation
import Alamofire



class  API {
    
    func signinResponse(user : String, pass : String, comp : @escaping (NSDictionary?)->()) {
        
        let url = URL(string: Constants.url)
        let param : Parameters = ["username":user,"password":pass]

        Alamofire.request(url!, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.default).responseJSON {
            response in
            if response.result.isSuccess {
                guard let d = response.result.value else {
                    print(response.result.error!)
                    return
                }
                comp((d as? NSDictionary)!)
            } else {
                print(response.result.error!)
            }
        }
    }
    
    let url = URL(string: Constants.bookURL)

    func getBooksData(comp : @escaping ([Book]?)->Void){
        Alamofire.request(url!, method: HTTPMethod.get, headers: Constants.header)
            .responseJSON {
                response in
                if response.result.isSuccess {
                   // print(response.result.value)
                    do {
                        let d = try JSONDecoder().decode([Book].self, from: response.data!)
                        comp(d)
                    }
                    catch {
                    
                    }
                }
        }
    }
    
    func postBookData(isbn : String, title : String, author : String, publisher: String, image : String, completion:@escaping (String?)->()){
        let param : Parameters = ["isbn":isbn, "title":title,"author":author,"publisher":publisher, "image":image]
        Alamofire.request(url!, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.default, headers : Constants.header).responseString {
            response in
            if response.result.isSuccess {
                guard let data = response.result.value else {
                    print(response.request)
                    return}
                completion(data)
                
            } else {
                print(response.error)
            }
        }
    }
    
    
    
}

