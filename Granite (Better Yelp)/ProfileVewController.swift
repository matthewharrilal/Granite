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

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var profileImage: UIImageView!
    
    let storageRef = Storage.storage().reference()
    let databaseRef = Database.database().reference()
    
    @IBAction func saveChanges(_ sender: UIButton) {
        
        
    }
    
    @IBAction func uploadImageButton(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(picker, animated:  true, completion: nil)
        
        
        
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
        
    }
    //
    //    profileImage.layer.cornerRadius = profileImage.frame.size.width/2
    //    profileImage.clipsToBounds = true
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
