//
//  searchingView.swift
//  class
//
//  Created by Lucas Armand on 3/29/18.
//  Copyright © 2018 Lucas Armand. All rights reserved.
//

import Foundation
import UIKit
import Firebase

var CurClassPasskey : String = ""

class searchingView : UITableViewController, UISearchBarDelegate{
    @IBOutlet weak var searchbar: UISearchBar!
    var classList : [DataSnapshot] = []
    var classNames:[String] = []
    var name = String()
    var isSearching: Bool = false
    var filteredData : [String] = []
    var filteredClasses : [DataSnapshot] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        searchbar.delegate = self
        
        ref?.child("Classes").observe(.childAdded, with: { (snapshot) in
            if(snapshot.exists()){
                print(snapshot.key)
                
                self.classList.append(snapshot)
                
                self.name = (snapshot.childSnapshot(forPath: "Name").value as? String ?? "Nil")
                print(self.name + " is the name given to the arrays")
                self.classNames.append(self.name)
                self.tableView.reloadData()
            }
            //self.classNames.append((classDict?["Name"] as? String)!)
            
        })
        //print(self.name + " is what was recieved outside the listener")
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == nil || searchText == ""{
            isSearching = false
            self.tableView.reloadData()
            searchBar.endEditing(true)
        }
        else{
            print("running")
            isSearching = true
            filteredData = self.classNames.filter({$0.localizedCaseInsensitiveContains(searchText)})
            self.filteredClasses = []
            ref?.child("Classes").observe(.value, with: { (snapshot) in
                let classes = snapshot as DataSnapshot
                for c in classes.children{
                    let schoolName = ((c as! DataSnapshot).childSnapshot(forPath: "School").value as! String)
                    print("School name",(schoolName))
                    if (schoolName.localizedCaseInsensitiveContains(searchText)){
                        print("found match for ",searchText,"in class",c)
                        self.filteredData.append((c as! DataSnapshot).childSnapshot(forPath:"Name").value as! String)
                    }
                }
                print(self.filteredData,"is the dataset")
                for name in self.filteredData{
                    for c in classes.children{
                        if ((c as! DataSnapshot).childSnapshot(forPath:"Name").value as! String == name){
                            self.filteredClasses.append((c as! DataSnapshot))
                            print("added:",c)
                        }
                    }
                    
                }
                print("filtered:",self.filteredData)
                self.tableView.reloadData()
            })

            
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isSearching){
            print("we are telling the table view",self.filteredData.count)
            return self.filteredData.count
        }else{
            return self.classNames.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if(isSearching){
            cell.textLabel?.text = self.filteredData[indexPath.row]
            print("searching for",self.filteredData[indexPath.row])
            
                  }else{
        cell.textLabel?.text = self.classNames[indexPath.row]
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexSelected : Int = indexPath.row
        if(isSearching){
            print(self.filteredClasses[indexSelected], "is being navigated to")
            curClassID = self.filteredClasses[indexSelected].key
            curClassName = self.filteredData[indexSelected]
            curClassDesc = self.filteredClasses[indexSelected].childSnapshot(forPath: "Description").value as? String ?? "Nil"
        }else{
        curClassID = classList[indexSelected].key
        curClassName = classNames[indexSelected]
        curClassDesc = classList[indexSelected].childSnapshot(forPath: "Description").value as? String ?? "Nil"
        }
        print("classNames are ",classNames,"selected is:",curClassName)
        ref?.child("Classes").child(curClassID).child("Passkey").observe(.value, with: { (snapshot) in
            if (snapshot.value as! String != ""){
                CurClassPasskey = snapshot.value as! String
                self.performSegue(withIdentifier: "toPasskey", sender: self)
            }else{
                self.performSegue(withIdentifier: "previewClass", sender: self)
            }
        })
    }

}
