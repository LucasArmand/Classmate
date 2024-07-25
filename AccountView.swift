//
//  AccountView.swift
//  class
//
//  Created by Lucas Armand on 3/29/18.
//  Copyright © 2018 Lucas Armand. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
class AccountView:UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var displayName: UITextField!
    var handle: AuthStateDidChangeListenerHandle!
    var user : User? = nil
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(user != nil){
            print("changing name to", textField.text)
            ref?.child("Users").child((user?.uid)!).child("DisplayName").setValue(textField.text)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func logout(_ sender: Any) {
        ref?.child("Users").removeAllObservers()
        try! Auth.auth().signOut()
    }
    override func viewDidLoad(){
        displayName.delegate = self
        handle = Auth.auth().addStateDidChangeListener{(auth,us) in
            if (us != nil){
                self.user = us
                ref?.child("Users").child((self.user?.uid)!).child("DisplayName").observe(.value, with : {(snapshot) in
                    self.displayName.text = snapshot.value as! String?
                })
            }
        }
    }
    
}
