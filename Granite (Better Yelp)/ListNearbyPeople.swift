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
import FirebaseStorage
import Alamofire


class ListNearbyPeople: UITableViewController {
    var hardCodedUsers = [HardCodedUsers]()
    var databaseRef = Database.database().reference().child("users")
    let cellID = "nearbyPeopleCell"
    var refHandle: UInt!
    var username: String?
    
    //let database = Database.database().reference().dictionaryWithValues(forKeys: String([users]))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseRef = Database.database().reference()
        fetchUsers()
    }
    func fetchUsers() {
        // Fetches users from database
        refHandle = databaseRef.child("users").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = HardCodedUsers(username: dictionary["username"] as! String, email: dictionary["email"] as! String, fullName: dictionary["fullName"] as! String, password: dictionary["password"] as! String
                )
                
                //let user = HardCodedUsers(username: String(describing: DataSnapshot()) )
                
                // What shpuld we pass in this username
                
                //user.setValuesForKeys(dictionary)
                self.hardCodedUsers.append(user)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                
            }
        })
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        username = currentCell.textLabel?.text
        performSegue(withIdentifier: "toProfile", sender: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hardCodedUsers.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID)
        let cell = tableView.dequeueReusableCell(withIdentifier: "nearbyPeopleCell", for: indexPath)
        cell.textLabel?.text = hardCodedUsers[indexPath.row].username
        username = hardCodedUsers[indexPath.row].username
        
        // So essentially what we are doing here is that we are is assigning the value of the cells that display the usernames of the other users to the variable username we declared at the top of the class and why we are doing this is becauase we want the username to be displaying the usernames of the users from firebase but still we have to pass that data over to the profile view controller and we know to do this we have to use the prepare for segue function
        // Set cell contents
        return cell
        
    }
    
    // Remember when we are passing data from one view controller to another we need to use the perfrom for segue method
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if let identifier = segue.identifier {
    //            if identifier == "toProfile" {
    //                //
    //                print("Cell was tapped on")
    //                if let profileViewController = segue.destination as? ProfileViewController {
    //                    let indexPath = tableView.indexPathForSelectedRow!
    //                    let hardUsers = hardCodedUsers[indexPath.row]
    //                }
    //
    //            }
    //
    //        }
    //    }
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier {
                        if identifier == "toProfile" {
                        let profileViewController = segue.destination as? ProfileViewController
                            //  So essentially we know that the username we gave declared earlier now contains the usernames of the users from firebase but yet we have to pass that on to the next view controller thats why we are in this function therefore we have to finda way to pass that data over
                         //   print(username)
                            print(profileViewController?.username)
                            
                            // So when we print this we are getting nil meaning nothing was assigned to it yet therefore we want to assign the cells usernames which we are doing in the lines of codes below
                           // And why would weassign the label text to username that is essentially hard coding the label text for each cell that we tap on
                        profileViewController?.username = username
            
            
                            //profileViewController?.usernameLabel.text = username
                            // we can not do this line of code above because we know that if we store the usernames within this username label.text variable only one username will get stored and thats what causes it to appear on every username when each cell is tapped
            
            
                        }
            
                    }
         
        
            
        
        
            if let identifier = segue.identifier {
                if identifier == "toProfile" {
                    let destination = segue.destination as? ProfileViewController
                    let indexPath = tableView.indexPathForSelectedRow
                    let hardUsers = hardCodedUsers[(indexPath?.row)!]
                    
                    
                }
            }
        }
    
}
