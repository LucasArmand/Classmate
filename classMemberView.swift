//
//  classMemberView.swift
//  class
//
//  Created by Lucas Armand on 3/29/18.
//  Copyright © 2018 Lucas Armand. All rights reserved.
//

import Foundation
import Firebase
import UIKit

class classMemberView : UITableViewController{
    
    var userList : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref?.child("Members").child(curClassID).observe(.childAdded, with: { (snapshot) in
            let member = snapshot.value as! String
            ref?.child("Users").child(member).child("DisplayName").observe(.value, with: { (snap) in
                self.userList.append(snap.value as! String)
                self.tableView.reloadData()
            })
        })
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = self.userList[indexPath.row]
        return cell
    }

}
