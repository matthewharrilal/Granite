//
//  HardCodedUserServices.swift
//  Granite (Better Yelp)
//
//  Created by Matthew on 7/25/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuthUI
import Firebase
import FirebaseDatabase
import FirebaseAuth

// Before we stat our code whenever we are dealing with backend servers what we essentially want is a service layer to keep the stuff that is happening in the background from getting in our way and potentially confusing us

struct UserService {
    static func create(user: HardCodedUsers) {
        
        create(forUser: user.username)
        
    }
    
    private static func create(forUser username: String) {
        let user = HardCodedUsers(username: username)
        let dict = user.dictValue
        let ref = Database.database().reference().child("UsernamesOfUsers").childByAutoId()
        // What this oneline of code above this essentially does is that it lets us give the user in the database a unique identification
        
        ref.setValue(dict)
        
        //So lets go over these lines of code and what they essentially do, so basically we are declaring a private static func and first and foremost
    }
}
