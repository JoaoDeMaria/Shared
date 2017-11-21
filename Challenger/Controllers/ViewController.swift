//
//  ViewController.swift
//  Challenger
//
//  Created by Vinicius Mangueira Correia on 13/11/17.
//  Copyright © 2017 Vinicius Mangueira Correia. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth
import GoogleSignIn

class ViewController: UIViewController {

    
    
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButton(_ sender: Any) {
    
        
        Auth.auth().signIn(withEmail: userEmail.text!, password: userPassword.text!) { (user, error) in
            if error != nil {
                return print(error)
                
            }else {
            self.performSegue(withIdentifier: "userAuthenticated", sender: sender)
            }
            
        }
    
    }
    
}

