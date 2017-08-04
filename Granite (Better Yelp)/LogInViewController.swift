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
import FirebaseDatabase
import Alamofire


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
//        if Auth.auth().currentUser?.uid != "" {
//       
//        }else {
//        
//         self.dismiss(animated: true, completion: nil)
//        print("This is a new user and it is not taking me back still")
//            // If we put a breakpoint here it is still not getting hit that means that we have to approach this in a different way
//        }
//        
        logOutNonExistingUsers()
        
        
        
        if emailTextField.text != "" {
        
        }else{
        logInCredentialsIsEmpty()
        }
        if passwordTextField.text != "" {
        
        }else{
        

        logInCredentialsIsEmpty()
        }
       // print("It is not taking me back anymore")
        
        // So we have to examine the issue that it is only taking us back with recurring users
        
        // So we have now confirmed that there is the glitch in the screens of the log in view controller when we try logging in with an existing user'
    }
        func logOutNonExistingUsers() {
        
        guard let email = emailTextField.text
            else{return}
        guard let password = passwordTextField.text
            else {return}
        
        
    Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
        if error != nil {
            // self.alertNonExistingUsers()
            self.dismiss(animated: true, completion: nil)
            print("User shall not enter")
           // self.alertNonExistingUsers()
      
        } else{
        self.alertNonExistingUsers()
            // This will never be hit becausae the if condition is always satisfied
            
            // Theory confirmed the user will not be allowed acess unless they have a real account that has been authenticated
        
        }
        }
    
    }
    func alertNonExistingUsers() {
        let alertingNonExistingUsers = UIAlertController(title: "This account does not exist", message: "Try again with a different account or create an account", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertingNonExistingUsers.addAction(cancelAction)
        self.present(alertingNonExistingUsers, animated:  true, completion:  nil)
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
    
        logIn()
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
                print("There is obviously a login flow issue")
                print(user)
                print(error?.localizedDescription)
                print("It is taking me back for a reason")
                // return
                // This get hits when you are signing in with a user that doesnt exist and the opposite for the else statement
                
            } else {
            print("Is this hitting correctly?")
                print("Error is occuring and what that error is: \(error?.localizedDescription)")
                // This else statement is getting hit when you sign in with user credentials that already hit
                // So now that we know when we use the log in screen for its intended functionality only this code will be hit
                // Maybe use an if statement to keep them logged in 
                
                // So in general this doesnt get hit unless you are signing it with a user that already eixsts
                // With users that exist this is not hitting
            
            }
           // self.dismiss(animated: true, completion: nil)
            
            // this was the cause of not being able to log in we were dismissing the view therefore every time this function is called which it is being called when the user taps on the log out button it is automatically dismissing the view but the question still arises why  even though this was still happening it wouldnt dismiss the view when users werent signed in its because in order for this to be called besides calling this function somewhere else maybe we can use this to our advantage
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



