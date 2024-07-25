//
//  DisplayDiscussionView.swift
//  class
//
//  Created by Lucas Armand on 8/2/17.
//  Copyright © 2017 Lucas Armand. All rights reserved.
//

import UIKit
import Firebase

class DisplayDiscussionView : UITableViewController{
    

    var content : [String] = []
    var author : [String] = []
    var messages : [DataSnapshot] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Discussions[selectedDisc])
        print("attempting to display ",Discussions[selectedDisc],"under",curClassID)
        ref?.child("Discussions").child(curClassID).child(Discussions[selectedDisc].key).child("Messages").observe(.value, with: { (s) in
            self.content = []
            self.author = []
            self.content = []
            
            for snapshot in s.children.allObjects as! [DataSnapshot]{
                self.messages.append(snapshot)
                print("Cur Discussion",Discussions[selectedDisc])
                self.content.append((snapshot.childSnapshot(forPath: "Content").value as? String)!)
                self.author.append((snapshot.childSnapshot(forPath: "Author").value as? String)!)
                self.tableView.reloadData()
            }
        })
        
    }
    override func viewDidDisappear(_ animated: Bool) {

    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "discCell", for: indexPath) as! DiscussionCell
        cell.authorText.text = author[indexPath.row]
        cell.contentText.text = content[indexPath.row]
        
        return cell
    }
    
   /* override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexSelected = indexPath.row
        performSegue(withIdentifier: "displayDiscussion", sender: self)
    }
*/
}

