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

protocol LogInViewControllerDelegate: class {
func finishLoggingIn()

}


class LogInViewController: UIViewController {
    var error = Error.self
    
    @IBOutlet weak var newUserButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let databaseRef = Database.database().reference(fromURL: "https://granite3-dbd3a.firebaseio.com")
    //  Making our references at the start of the project makes our lives easier in terms of now we know what we already have and we just declare them here so we are not doing it while we go through the project
    
    
    @IBAction func logInButton(_ sender: UIButton) {
        if emailTextField.text != "" {
            
        }
            
        else {
            // logInCredentialsIsEmpty()
        }
        
        if passwordTextField.text != "" {
            
        }
            
        else {
            
            
            // logInCredentialsIsEmpty()
        }
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            // if there is an error meaning that it will be the opposite of nil
            if error != nil {
                self.logInCredentialsIsEmpty(error: error!)
                print("There is obviously a login flow issue")
                print(user)
                print(error?.localizedDescription)
                print("It is taking me back for a reason")
                // return
                // This get hits when you are signing in with a user that doesnt exist and the opposite for the else statement
                
                // So lets explain what is essentially happening here and what is occuring is that we are saying if the error is occuring here we want these login alerts to occur which makes sense because we know if something is nil it means that there is no data within it now if there is no data within an error that means the error is non existent
            } else {
                print("User is just signed in and their user defaults has not been set yet")
                UserService.show(forUID: (user?.uid)!, completion: { (user) in
                    if let user = user {
                    HardCodedUsers.setCurrent(user, writeToUserDefaults: true)
                    self.finishLoggingIn()
                    print("User defaults has now been set")
                    
                    } else {
                    print("Error: User does not exist")
                        return
                    
                    }
                })
                self.performSegue(withIdentifier: "toHome", sender: nil)
                
            }
            // So what is happening in this else statement is that we are saying before the user defaults stores the user locally we want to print this statement that the user has been signed in but they havent been saved to the user defaults
            // Now the problem that was occuring that the user isnt being saved to user defaults and as a result of that the corresponding print statement isnt being printed, and the reason being for this problem occuring was that the no user data was being passed into the completion handler and the way we went about this was in our hard coded user services was because we were just accounting for the simple fact that the user had been already logged in therefore we werent writing to user defaults but in our case there was no existing user logged in therefore meaning we had to accoutn for a user logging in and then saving them to user defaults
        }
      
        // The reason we changed the segue from the button to the next view controller to the home to the next view controller is  becuase if we left it that way we would have been stuck with a button that just segues even if the alerts are present and we see that we do not want that if their is an error we want our users to be presented with an error 
    
    }
    func finishLoggingIn() {
        print("User is done logging in from the log in view controller")
    }
    
    func logInCredentialsIsEmpty(error: Error) {
        if emailTextField.text == "" || passwordTextField.text == "" {
            let emptyLogInCredentials = UIAlertController(title: "Missing Log In Input", message: "Some of your log in credentials seem to be empty please double check the required fields", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "You are forgiven", style: .default, handler: nil)
            emptyLogInCredentials.addAction(cancelAction)
            self.present(emptyLogInCredentials, animated: true, completion: nil)
        }
        else {
            switch(error.localizedDescription) {
            case "The email address is badly formatted.":
                let invalidEmailAlert = UIAlertController(title: "This email address is badly formatted", message: "Please try again with a different email address, if not please create an account", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Try Again", style: .default, handler: nil)
                invalidEmailAlert.addAction(cancelAction)
                self.present(invalidEmailAlert, animated: true, completion:  nil)
                break;
                
            case "There is no user record corresponding to this identifier. The user may have been deleted.":
                let nonExistentUser = UIAlertController(title: "Non-existent Account", message: "This account does not correspond to any records within our database", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Try Again", style: .default, handler: nil)
                nonExistentUser.addAction(cancelAction)
                self.present(nonExistentUser, animated: true, completion: nil)
                break;
            case "Try a different password.":
                let invalidPassword = UIAlertController(title: "Wrong Password", message: "Try logging in with a different password", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Try Again", style: .default, handler: nil)
                invalidPassword.addAction(cancelAction)
                self.present(invalidPassword, animated: true, completion:  nil)
                break;
                
            default:
                let logInFailedAlert = UIAlertController(title: "Trouble Logging In", message: "We are having trouble logging you in", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Try Again", style: .default, handler: nil)
                logInFailedAlert.addAction(cancelAction)
                self.present(logInFailedAlert, animated:  true, completion:  nil)
            }
            
        }
        
        
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
        
        newUserButton.layer.cornerRadius = 10
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    
}



