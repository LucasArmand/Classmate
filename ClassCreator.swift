//
//  ClassCreator.swift
//  class
//
//  Created by Lucas Armand on 3/27/18.
//  Copyright © 2018 Lucas Armand. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuthUI

class ClassCreator : UIViewController, UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    var handle: AuthStateDidChangeListenerHandle!
    @IBOutlet weak var classPasskey: UITextField!
    @IBOutlet weak var usePasskey: UISwitch!
    @IBOutlet weak var className: UITextField!
    @IBOutlet weak var classDesc: UITextField!
    @IBOutlet weak var schoolName: UITextField!
    var user : User? = nil
    
    @IBAction func create(_ sender: Any) {
            let classKey = ref?.child("Classes").childByAutoId().key
            print("CREATING CLASS",self.className.text!,"UNDER USER",user?.uid)
            if (!self.usePasskey.isOn){
                self.classPasskey.text = ""
            }
        
            let classInfo = ["Name":self.className.text,
                             "Description":self.classDesc.text,
                             "School":self.schoolName.text,
                             "Passkey":self.classPasskey.text] as [String:Any]

        ref?.child("Classes").child(classKey!).updateChildValues(classInfo)
        ref?.child("Members").child(classKey!).childByAutoId().setValue(user?.uid)
        ref?.child("Users").child((user?.uid)!).child("Classes").childByAutoId().setValue(classKey!)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.classPasskey.delegate = self
        self.className.delegate = self
        self.classDesc.delegate = self
        self.schoolName.delegate = self
        handle = Auth.auth().addStateDidChangeListener{(auth,us) in
            if (us != nil){
                self.user = us!
            }
        }

        
    }
}
