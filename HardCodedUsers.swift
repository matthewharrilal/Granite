//
//  HardCodeduSERS.swift
//  Granite (Better Yelp)
//
//  Created by Matthew on 7/25/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseDatabase
import FirebaseAuth

class HardCodedUsers: NSObject {
    var username: String
    
// So what we are essentially doing in our code right now is that we want to make these hard coded users simply for the functionality of using the path fucntionality in google maps and the reason we even want to implement googlee maps in the first place is because we want have the abiltiy to not only have the table view cells be populated with users that have the same location as us but also to enable gettig the directions right now the as f this point we dont even care baout finding the users in the same location we just want to make a pathway to them using google maps 
    
    // just to confirm that we are passing in the username argument label into the class property called username and again what this essentially does is that it lets us make every instance that comes aas a result of this class have to have a username and that makes sense once again becuas eevvery instance represents the username of each member so once again each meber has to have a username which makes sense because whats the point if they cant have a username
    
    init(username: String) {
        self.username = username
        // So we already know that we use initializers as the blueprints for instances to come of the class so essentially what we are doing right now is that we have to set the argument label username equal to the property username we have created for the class so basically what we are doing is that every instance that comes as a result of this class is going tobe initalized with this username argument label that is of type string and we can pass in any string which will corespond to the users unique username not to be confused with their uid
    }

    // now lets not forget to implement data in a database we have to make a dictionary where the key would be what we type to retireve the data for that key
    // We are constructing a dictionary right now
    var dictValue: [String: Any] {
    return["username": username]
        // So what is essentially happening here is that we are passing in the string username into the class poroperty called username and what this essentially does is that like we said earlier that every instance is initialized with the propery username meaning that every user has a username so basically what we are doing right now is that for every username value or the string they chsoose to be their username we are assigning it to the key "username"
        
        // Juat a side noe the reason we dont need a failable initializer is because we have no use for user anonymous functionality
        
        
    
    }
}
