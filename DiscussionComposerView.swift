//
//  DiscussionComposerView.swift
//  class
//
//  Created by Lucas Armand on 3/26/18.
//  Copyright © 2018 Lucas Armand. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseAuthUI
class DiscussionComposerView : UIViewController, UITextViewDelegate, UITextFieldDelegate{
    var handle: AuthStateDidChangeListenerHandle!
    var discussion : String = ""
    var author = ""
    
    
    @IBOutlet weak var titletext: UITextField!
    @IBOutlet weak var content: UITextView!
    
    func textViewShouldReturn(_ textField: UITextField) -> Bool {
        print("return hit")
        textField.resignFirstResponder()
        return true
    }
    @IBAction func post(_ sender: Any) {
        handle = Auth.auth().addStateDidChangeListener{(auth,user) in
            if ((user) != nil){
                let disckey = ref?.child("Discussions").child(curClassID).childByAutoId().key
                let contkey = ref?.child("Discussions").child(curClassID).child(disckey!).child("Messages").childByAutoId().key
                ref?.child("Users").child((user?.uid)!).observe(.value, with : {(snapshot) in
                    let nameDict = snapshot.value as! NSDictionary
                    print (nameDict["DisplayName"])
                    self.author = (nameDict["DisplayName"] as? String)!
                    print("author is " + self.author)
                    let master = ["Author":self.author,
                                  "Title":self.titletext.text] as [String : Any]
                    ref?.child("Discussions").child(curClassID).child(disckey!).updateChildValues(master)
                    let post = ["uid": user?.uid,
                                "Author": self.author,
                                "Content": self.content.text] as [String : Any]
                    ref?.child("Discussions").child(curClassID).child(disckey!).child("Messages").child(contkey!).updateChildValues(post)
                    ref?.child("Discussions").child(curClassID).child(disckey!).observe(.value, with: { (snapshot) in
                        print(snapshot)
                        Discussions.append(snapshot)
                    })
                    
                })
            }
        }
    }
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        print("is running composer")
        self.content.delegate = self
        self.titletext.delegate = self
    }
}
