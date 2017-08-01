//
//  CreateUsername.swift
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
import FirebaseDatabase
import FirebaseStorage

class CreateUsername: UIViewController {
    
    // Declaration of the database reference
    let databaseRef  = Database.database().reference(fromURL: "https://granite3-dbd3a.firebaseio.com")
    // Outlets
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var agreementTextField: UITextField!
    
    
    
    
    
    // Actions
    @IBAction func createAccount(_ sender: UIButton) {
        signUp()
        
        if fullName.text != "" {
            
            
        } else{
            textFieldIsEmpty()
        }
        
        if emailTextField.text != "" {
            
        }
        else{
            textFieldIsEmpty()
        }
        if usernameTextField.text != "" {
            
        }else {
            textFieldIsEmpty()
        }
        if passwordTextField.text != "" {
            
        }
        else{
            textFieldIsEmpty()
            
        }
        //        if agreementTextField.text != nil {
        //
        //        } else {
        //            textFieldIsEmpty()
        //        }
        
        if agreementTextField.text == "Yes"  {
            
            
        }
        else{
            print("This statement is being printed because the user did not subjugate to the agreement of consent correctly")
            textFieldIsEmpty()
            
        }
        // Why is this function being called even if the text matches the exact same syntax as the one we want we have to research how to dismiss these notifications later
        
        // The reason their is only one alert kind for both actions is becuase i dont think you can asssign two alerts to one button
        
        // If they say no to the consent agreement they can not have access to the application
        
    }
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
    
    func textFieldIsEmpty() {
        let ifTextFieldIsEmpty = UIAlertController(title: "Missing required text fields", message: "Please double check the text fields and see if you have entered them correctly and in addition no individual is permitted to use this app unless they have consent from a guardian or is over the age of 18", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Im Sorry", style: .default, handler: nil)
        ifTextFieldIsEmpty.addAction(cancelAction)
        self.present(ifTextFieldIsEmpty, animated: true, completion: nil)
    }
    
    func ageConsentAgreement() {
        let usersAgreement = UIAlertController(title:"Warning You Probably Spelled Something Wrong", message: "The reason you are getting this messgae is probaly becuase you did not make sure that your response was case sensitive make sure it is spelled the exact same way as the placeholder text", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Agree To These Terms", style:
            .default, handler: nil )
        usersAgreement.addAction(cancelAction)
        self.present(usersAgreement, animated: true, completion: nil)
        
        
    }
    
    
    func signUp() {
        guard let fullName = fullName.text
            else {
                print("full name errror")
                return
        }
        guard let email = emailTextField.text
            else {
                print("email issue")
                return
        }
        guard let username = usernameTextField.text
            else{
                print("username issue")
                return
        }
        guard let password = passwordTextField.text
            else{
                print("password issue")
                return
        }
        // The verifcation of new users
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error)
                return
            }
            // We have to give each new user that is being made a specific user identification and why we dont put this code in the log in function is because if they are able to log in that means they already have a unique user identification
            // and of course we know  uid is for firebase
            guard let uid = user?.uid // Here we are essentially casting their user uid as a string
                else {
                    print("user uid issue")
                    return
            }
            let userReference = self.databaseRef.child("users").child(uid)
            // We are essentailly holding the users user identification here
            let values = ["username": username, "email": email, "password": password, "fullName": fullName]
            // What we are essentially doing here is that we are creating these keys to hold these specific users information so for example we are creating a key to contain all our
            userReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
                if error != nil {
                    print("error updating child values")
                    print(error)
                    return
                }
                self.dismiss(animated: true, completion: nil)
            })
        }
        
    }
    
    
    func savingUser() {
        
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()
        // Whenever we use user defaults we have to use this method or else the value will not get saved
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("user is automatically logged in from now on")
        if let x = UserDefaults.standard.object(forKey: "isLoggedIn") {
            emailTextField.text = x as! String
            passwordTextField.text = x as! String
        }
    }
    
    
    
}
