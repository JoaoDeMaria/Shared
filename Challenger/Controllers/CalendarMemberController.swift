//
//  CalendarMemberController.swift
//  Challenger
//
//  Created by Vinicius Mangueira Correia on 01/12/17.
//  Copyright © 2017 Vinicius Mangueira Correia. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class CalendarMemberController: UITableViewController {

    
    var members : [User]  = []
    var group : Group? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMembers()
    }

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func loadMembers() {
        let ref = Database.database().reference()
        let userRef = Database.database().reference()
        ref.child("group").child((group?.key)!).child("users").observeSingleEvent(of: .value, with: { (snapshot) in
//            let snapshots = snapshot.children.allObjects.flatMap { $0 as? DataSnapshot }
//            let keys = snapshots.map { $0.key }
//            var users = (snapshots.flatMap { User.deserialize(from: $0.value as? NSDictionary) })
//             print(users)
            if let users = snapshot.value as? NSArray {
                for user in users {
                    userRef.child("users").child(user as! String).observeSingleEvent(of: .value, with: { (snapshot) in
                        guard let dict = snapshot.value as? NSDictionary else { return }
                        let user = User.deserialize(from: dict)
                        self.members.append(user!)
                        self.tableView.reloadData()
                    })
                }
            }
    })
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
        cell.email.text = members[indexPath.row].name
       return cell
    }
}