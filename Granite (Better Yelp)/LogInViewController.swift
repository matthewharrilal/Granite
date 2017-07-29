//
//  LogInViewController.swift
//  Granite (Better Yelp)
//
//  Created by Matthew on 7/28/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseAuth
import FirebaseStorage

var isLogIn: Bool = true
class LogInViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    let databaseRef = Database.database().reference(fromURL: "https://granite3-dbd3a.firebaseio.com")
    
    
    @IBAction func logInButton(_ sender: Any) {
        
        logIn() // Calling this function here because this our action function for the log in button function
        
    }
    //  Making our references at the start of the project makes our lives easier in terms of now we know what we already have and we just declare them here so we are not doing it while we go through the project
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    
        
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
    func logIn() {
        guard let email = emailTextField.text
            else {
                print("email issue")
                return
        }
        guard let password = passwordTextField.text
            else {
                print("password issue")
                return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error)
                return
                
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    
    
    
}


