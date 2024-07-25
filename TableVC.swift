//
//  TableVC.swift
//  class
//
//  Created by Lucas Armand on 8/2/17.
//  Copyright © 2017 Lucas Armand. All rights reserved.
//

import UIKit
import Firebase

var discTitle = String()
var discContent = String()
var Discussions :[DataSnapshot] = []
var selectedDisc = -1
var discussionNames:[String] = []

class TableVC : UITableViewController{
   
    var indexSelected = 0
    var cellNum = 0
    
    override func viewDidLoad() {

        
        self.automaticallyAdjustsScrollViewInsets = false
        super.viewDidLoad()

        discTitle = ""
        discContent = ""
        Discussions = []
        discussionNames = []
        ref?.child("Discussions").child(curClassID).observe(.value, with: { (snapshot) in
            self.tableView.reloadData()
            discTitle = ""
            discContent = ""
            Discussions = []
            discussionNames = []
                for d in snapshot.children{
                    
                    Discussions.append(d as! DataSnapshot)
                    discTitle = ((d as AnyObject).childSnapshot(forPath: "Title").value as? String)!
                    discussionNames.append(discTitle)
                    self.tableView.reloadData()
                }
            print(Discussions)
        })
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(discussionNames,"is the amount of rows for the discussions list")
        return discussionNames.count    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cellNum += 1
        print("index path is " + String(indexPath.row))
        print("IN FUNC: this is cell num " + String(self.cellNum) + " and this is dis names " + String(discussionNames.count))
        cell.textLabel?.text = discussionNames.reversed()[indexPath.row]
        print("completed")
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexSelected = indexPath.row
        selectedDisc = discussionNames.count - indexPath.row - 1
        print("moving to ",String(selectedDisc)," with name " , discussionNames.reversed()[indexPath.row])
        performSegue(withIdentifier: "displayDiscussion", sender: self)
    }
    
}
