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

class ListNearbyPeople: UITableViewController {
    var hardCodedUsers = [HardCodedUsers]()
    var databaseRef = Database.database().reference().child("users")
    let cellID = "nearbyPeopleCell"
    var refHandle: UInt!
    
    
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
                let user = HardCodedUsers(username: String(describing: dictionary))
                
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hardCodedUsers.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID)
        cell.textLabel?.text = hardCodedUsers[indexPath.row].username
        // Set cell contents
        return cell
        
    }
    
    // Remember when we are passing data from one view controller to another we need to use the perfrom for segue method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toProfile" {
                //
                print("Cell was tapped on")
                if let profileViewController = segue.destination as? ProfileViewController {
                    let indexPath = tableView.indexPathForSelectedRow!
                    let hardUsers = hardCodedUsers[indexPath.row]
                }
                
            }
            
        }
    }
    
    
}
