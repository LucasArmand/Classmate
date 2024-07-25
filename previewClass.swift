//
//  previewClass.swift
//  class
//
//  Created by Lucas Armand on 3/29/18.
//  Copyright © 2018 Lucas Armand. All rights reserved.
//

import Foundation
import UIKit
import Firebase
class previewClass : UIViewController{
    var isFollowing : Bool = false
    var handle: AuthStateDidChangeListenerHandle!
    @IBOutlet weak var classDesc: UILabel!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var className: UILabel!
    var user : User? = nil
    @IBAction func joinClass(_ sender: Any) {
                ref?.child("Users").child((user?.uid)!).child("Classes").childByAutoId().setValue(curClassID)
                ref?.child("Members").child(curClassID).childByAutoId().setValue(user?.uid)
    }
    override func viewDidLoad() {
        self.className.text = curClassName
        self.classDesc.text = curClassDesc
        handle = Auth.auth().addStateDidChangeListener{(auth,us) in
            if((us) != nil){
                self.user = us
            ref?.child("Users").child((self.user?.uid)!).child("Classes").observe(.value, with: { (snapshot) in
                let followedClasses = snapshot.value as? NSDictionary
                self.isFollowing = false
                if (followedClasses != nil){
                    for c in followedClasses!{
                        if c.value as? String == curClassID{
                        self.isFollowing = true
                        }
                    }
                }
                if(self.isFollowing){
                    self.joinButton.isEnabled = false
                }
            })
            }
        }
    }
}


