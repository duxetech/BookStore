//
//  ViewController.swift
//  BookStore
//
//  Created by Karthik on 08/08/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    let parser = SigninApiParser()
    
    @IBOutlet var tfUser: UITextField!
    
    @IBOutlet var tfPass: UITextField!
    
    @IBAction func loginTapped(_ sender: Any) {
        let username = tfUser.text
        let password = tfPass.text
        
        if username == "" || password == "" {
            return
        }
        parser.signinCheck(name: username!, pass: password!)
        parser.reload = { [weak self] in
            if (self?.parser.loggedIn)! {
                self!.performSegue(withIdentifier: "detail", sender: self)
            }
        }
        clear()
    }

    
    func clear(){
        tfUser.text=nil
        tfPass.text=nil
    }
    
}

