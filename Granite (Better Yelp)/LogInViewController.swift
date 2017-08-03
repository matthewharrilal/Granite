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

//var isLogIn: Bool = true
class LogInViewController: UIViewController {
    
    
    @IBOutlet weak var newUserButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
       
    let databaseRef = Database.database().reference(fromURL: "https://granite3-dbd3a.firebaseio.com")
    //  Making our references at the start of the project makes our lives easier in terms of now we know what we already have and we just declare them here so we are not doing it while we go through the project
    
    
    @IBAction func logInButton(_ sender: UIButton) {
        
        
        logIn() // Calling this function here because this our action function for the log in button function
        if emailTextField.text != "" {
        
        }else{
        logInCredentialsIsEmpty()
        }
        if passwordTextField.text != "" {
        
        }else{
        
        logInCredentialsIsEmpty()
        }
        print("It is not taking me back anymore")
        
        // So we have to examine the issue that it is only taking us back with recurring users
        
        // So we have now confirmed that there is the glitch in the screens of the log in view controller when we try logging in with an existing user'
        
        
    }
    
    func logInCredentialsIsEmpty() {
        let emptyLogInCredentials = UIAlertController(title: "Missing Log In Input", message: "Some of your log in credentials seem to be empty please double check the required fields", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "You are forgiven", style: .default, handler: nil)
        emptyLogInCredentials.addAction(cancelAction)
        self.present(emptyLogInCredentials, animated: true, completion: nil)
    
    }
    func emailIsAlreadyRegistered() {
        let registeredEmail = UIAlertController(title: "Email is already registered with an account", message: "Try using another email adress to log in", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Allow me to try again", style: .default, handler: nil)
        registeredEmail.addAction(cancelAction)
        self.present(registeredEmail, animated: true, completion: nil)
    
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        // Adding programmatic constraints to our log in view controller
        
       
//        newUserButton.translatesAutoresizingMaskIntoConstraints = false
//        logInButton.translatesAutoresizingMaskIntoConstraints = false
    
        
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
    
//    
//    func savingUser() {
//        
//        UserDefaults.standard.set(true, forKey: "isLoggedIn")
//        UserDefaults.standard.synchronize()
//        // Whenever we use user defaults we have to use this method or else the value will not get saved
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        print("user is automatically logged in from now on")
//        if let x = UserDefaults.standard.object(forKey: "isLoggedIn") {
//        emailTextField.text = x as! String
//        passwordTextField.text = x as! String
//        }
//    }
    
    
    
}


