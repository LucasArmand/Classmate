//
//  ViewController.swift
//  class
//
//  Created by Lucas Armand on 8/2/17.
//  Copyright © 2017 Lucas Armand. All rights reserved.
//

import UIKit
import Firebase



var curClassID : String = ""
var curClassName : String = ""
var curClassDesc : String = ""
var curClassSchool : String = ""
class ViewController: UITableViewController {

    var handle: AuthStateDidChangeListenerHandle!
    var classList : [DataSnapshot] = []
    var classNames:[String] = []
    var name = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handle = Auth.auth().addStateDidChangeListener{(auth,user) in
            if((user) != nil){
        ref?.child("Users").child((user?.uid)!).child("Classes").observe(.childAdded, with: { (s) in
            print(s.value ," is the intermediary")
            ref?.child("Classes").observe(.childAdded, with: { (snapshot) in
            if(snapshot.key == s.value as! String){
                print(snapshot.key)
            
            self.classList.append(snapshot)
            
            self.name = (snapshot.childSnapshot(forPath: "Name").value as? String ?? "Nil")
            print(self.name + " is the name given to the arrays")
            self.classNames.append(self.name)
                self.tableView.reloadData()
            
            
            
                }
            })
                })
            }
            //self.classNames.append((classDict?["Name"] as? String)!)
        }
    }
        //print(self.name + " is what was recieved outside the listener")

        // Do any additional setup after loading the view, typically from a nib.

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.classNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = self.classNames[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexSelected : Int = indexPath.row
        curClassID = classList[indexSelected].key
        curClassName = classNames[indexSelected]
        curClassDesc = classList[indexSelected].childSnapshot(forPath: "Description").value as? String ?? "Nil"
        curClassSchool = classList[indexSelected].childSnapshot(forPath: "School").value as? String ?? "Nil"
        print("classNames are ",classNames,"selected is:",curClassName)
        performSegue(withIdentifier: "chosenClass", sender: self)
    }
}



