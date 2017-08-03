//
//  ProfileVewController.swift
//  Granite (Better Yelp)
//
//  Created by Matthew on 7/26/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import CoreData
import Alamofire

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var hardCodedUsers = [HardCodedUsers]()
    @IBOutlet weak var profileImage: UIImageView!
    var username: String?
    var users = [HardCodedUsers]()
    
    
    
    @IBOutlet weak var usernameLabel: UILabel!{
    UIStoryboardSegue.init(identifier: "toProfile", source: ListNearbyPeople, destination: ProfileViewController)
    let sourceViewController =
    
    }

   
    @IBAction func logoutButton(_ sender: UIButton) {
        logout()
    }
    let storageRef = Storage.storage().reference()
    var databaseRef = Database.database().reference()
    
    @IBAction func saveChanges(_ sender: UIButton) {
        saveChanges()
        profileUsernames()
    }
    
    @IBAction func uploadImageButton(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(picker, animated:  true, completion: nil)
        
        // So what we are essentially doing let us take this to the basics first and foremost what is happening is that we are saying that when the user presses upon this uploadImageButton that we want the following code to be executed and what is going to happpen is that we want to give this let constant we are declaring calledpicker to essentially be its own delegate and what that means is that we are giving its own set of protocols or in other words we can think about this in the way that we are giving it its own set of blueprints as opposed to making it subjugated to the default blueprints or protocols it originally came from
        
        // in the next line of code what is essentially happening is that well first we are making this picker of type uiimagepickercontroller and what that it essentially does is that it gives us all the properties of the uiimagepickercontroller within this picker controller and then from there we make it its own delegate and like we said that gives us our own set of blueprints and in the next line of code we are basically saying that we can allow editing meaning if they can modify the existing image
        
        // In the next line of code what is essentially happening is that we are giving a source for these photos to come from and for that source we are using the uiimagepickercontroller photo library meaning we have access to all the default photos
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        
        dismiss(animated: true, completion: nil)
    }
    
      func saveChanges() {
        // Save changes to the modifications we made to the profile
        
        
        let imageName = NSUUID().uuidString
        
        let storedImage = storageRef.child("profileImage").child(imageName)
        
        if let uploadData = UIImagePNGRepresentation(self.profileImage.image!)
        {
            
            storedImage.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print(error)
                    return
                    
                }
                storedImage.downloadURL(completion: { (url, error) in
                    if error != nil {
                        print(error)
                        return
                        
                    }
                    if let urlText = url?.absoluteString{
                        self.databaseRef.child("users").child((Auth.auth().currentUser?.uid)!).updateChildValues(["pic" : urlText], withCompletionBlock: { (error, ref ) in
                            if error != nil {
                                print(error)
                                return
                                
                            }
                        })
                        
                    }
                })
            })
        }
        print("The user's profile image has been saved to their profile")
        
        // Their image is succesfully chnaging but what is occuring is that the username is all under one users name as well as the image doesnt actually change it justs does in firebase but since they are all under one username what is occuring is that the photos are only saving within that users values for pic
        
        // So what we have to do is first fix the issue that when we press the save changes button the username saves for all the users but what we want is that when we press the save change button that it only saves for the individual user
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController,  info: [String: Any]) {
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImageFromPicker = editedImage
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker {
            profileImage.image = selectedImage
            
        }
        dismiss(animated: true, completion: nil)
        
        // What this function essentially allows us to do is that it is basically saying that if the user edits the image ket that be the image that is set for their profile
        
        // the second condition basically states that if the user chooses to leave the originial images as their profile image let that happen
        
        // if the user chooses the selected image then let that be the image that is set as their profile image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if  Auth.auth().currentUser?.uid == nil {
            logout()
        }
        setupProfile()
      
      
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Now we know that we call the view will appear function when we want things to be loaded more than once as opposed to where view did load are thingd that only are called once and we know we want things to be called more than once becauase everytime the user taps on a table view cell we want the thing to be ccalled more than once that it displays a username that coressponds to the user rather than the same one for each user
        //viewwillappear()
    
        usernameLabel.text = username
        
        
        
                // So on the bright side we have enabled the ability to pass the data from the table view cell onto the username label in the profile view controller yet we have no way to be able to assign the label to the corresponding users
    }
    
//    func viewwillappear() {
//     self.username = usernameLabel.text
//    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//         self.usernameLabel.text = username
//    }
    
   // So essentially what we are trying to do is that we are trying to display the users username when we tap on the corresponding table view cell so what we have to do is in our prepare for segue function in our table view controller and the reason we dont have to use a snapshot is because we do not want to call the data from firebase rather we want to get the data from the table view cell and we know when we are passing data to two view controllers we want to use the prepare for segue function
        
        
    
    
    func setupProfile() {
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
        let uid = Auth.auth().currentUser?.uid
        databaseRef.child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? [String: AnyObject] {
              //self.usernameTextField.text = dict["username"] as! String
                if let profileImageURL = dict["pic"] as? String {
                    let url = URL(string: profileImageURL)
                    URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                        if error != nil {
                            print(error)
                            return
                        }
                        DispatchQueue.main.async {
                            self.profileImage.image = UIImage(data:data!)
                        }
                    }).resume()
                    
                }
                
                
            }
        })
        
    }
    
    func profileUsernames() {
//        let uid = Auth.auth().currentUser?.uid
//        // This databaseRef just holds the reference to our database
//        databaseRef.child("users").child(uid!).observeSingleEvent(of: .value, with: { (usernameSnapshot) in
//            if let dictionary = usernameSnapshot.value as? [String: AnyObject] {
//                //self.usernameTextField.text = dictionary["username"] as! String
//                for _ in self.hardCodedUsers {
//                    let url = URL(string: self.usernameTextField.text!)
//                    URLSession.shared.dataTask(with: url!, completionHandler: {(text, response, error) in
//                        if error != nil {
//                        print(error)
//                            return
//                        }
//                        DispatchQueue.main.async {
//                     //       self.usernameTextField.text = UITextField(text: usernameTextField.text)
//                        }
//                    }).resume()
//                                    }
//                
//                
////                for _ in self.hardCodedUsers {
////                    self.usernameTextField.text = dictionary["username"] as! String
////                    
////                    print("The user's username has been saved")
////                }
//                
//                
//            }
//        })
//        
        
        
    }
    
    // Essentially in the function above what we are doing is that we are setting up the profile details and how this occurs is that for the first lines of codes we are basically editing the shape of how the picture is displayed in the image view of the users library
    // In the very first line of code we are saying in this if condition that if the user doesnt have a user identification we want to call the logout function which logs them out and this makes sense if the user doesnt have a user identification which is assgined to every user when they create their accont is that we want to log them out of the account this could serve as a security measure
    // In the next several lines of code we are setting up a reference to the users identification and saying that with that snapshot of data we want to grab the username value of the user and set that equal to the username text label that is in their profile to display their username and cast it as a string so it is readble by other users
    
    // Next what is happening is that we are
    
    func logout() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let logInViewController = storyboard.instantiateViewController(withIdentifier: "Home")
        let viewController = ViewController()
        self.present(viewController, animated: true, completion: nil )
        
        // So this function is basically the function we call whenever the user would want to logout from their account
        
        // and how we went about executing this code is that we set this new let constant called storyboard and what this essentially does is that representing the main storyboard
        // In the next line of code we are declaring a new let constant called logInViewController and what this let constant essentially does is that we take the storyboard constant that we declared in the previous line of code and what we do with that is that we are using this new let constant we are declaring to reprsent the transition that occurs when the the user wants to go from wherever they are in the main storyboard and go to the view controller they want to end up in by giving the view controller an identifier for where they want to end up in and depending on where you call this function that how the transition is going to occur for example we call this function in the log out button action because when we press the logout button we want to be transition to the view controller that we gave the identifier for
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
