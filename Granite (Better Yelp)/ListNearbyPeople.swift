//
//  ListNearbyUsers.swift
//  Granite (Better Yelp)
//
//  Created by Matthew on 7/24/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseDatabase
import FirebaseAuth

class ListNearbyPeople: UITableViewController {
    
    
    
    
    var users = [HardCodedUsers]()
    // We are creating an instance of the class hard coded users and initalizing it as an array
    //  users = ["John", "Mike", "Steven"]
    
    var referenceToNearbyPeople = Database.database().reference().child("UsernamesOfUsers")
    let uid = Auth.auth().currentUser?.uid
    // So lets go over these lines what is essentially happening is that we are declaring this variable that is called reference to nearby people and what separates this from the referece we made in the hardcoded usr services file is by the context in which we did it so basically what we did is that we made in this file not only a way to authenticate the users to see if they are recurring but also we created a reference to nearby people which soley depends on location and we only creating a reference because if they are nearby their usernames will show up and to do that we have to get a reference to their usernames as well as contain and extract that data which we wil do next
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchUsersFromDatabase()
    }
    
    
    
    //func fetchUsersFromDatabase() {
        
       // Database.database().reference().child("UsernamesOfUsers").observeSingleEvent(of: .value, with: { (snapshot) in
       //     if let dictionary = snapshot.value as? [String: AnyObject] {
        //        for (_, value) in dictionary {
       //
          //          if let username = value["username"] {
           //             let user = HardCodedUsers(username: String(describing: username!))
           //             self.users.append(user)
                        
                        
                        // We havent made any users yet so therefore when we do save the users to the database they will save and reload the table view with them
            //        }
            //    }
         //   }
       //
       // })
        
   // }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that canbe recreated
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableView1",for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text =  user.username      //["Tom","Dick","Harry"]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
}





