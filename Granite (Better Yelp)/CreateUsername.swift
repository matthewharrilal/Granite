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
        
        if emailTextField.text == nil {
            textFieldIsEmpty()
        }
        if usernameTextField.text == nil {
            textFieldIsEmpty()
        }
        if passwordTextField.text == nil {
            textFieldIsEmpty()
        }
        if agreementTextField.text == nil {
        textFieldIsEmpty()
        }
        
        if agreementTextField.text != "Yes" || agreementTextField.text != "No" {
        ageConsentAgreement()
        }
        // Why is this function being called even if the text matches the exact same syntax as the one we want we have to research how to dismiss these notifications later
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func textFieldIsEmpty() {
        let ifTextFieldIsEmpty = UIAlertController(title: "Missing required text fields", message: "Please double check the text fields and see if you have entered them correctly", preferredStyle: .alert)
        
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
            let values = ["username": username, "email": email, "password": password, "Full Name": fullName]
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
}
