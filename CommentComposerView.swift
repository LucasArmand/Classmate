//
//  CommentComposerView.swift
//  class
//
//  Created by Lucas Armand on 3/25/18.
//  Copyright © 2018 Lucas Armand. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseAuthUI
class CommentComposerView : UIViewController, UITextViewDelegate{
	var handle: AuthStateDidChangeListenerHandle!
	var discussion : String = ""
	var author = ""
	var user :User? = nil
	@IBOutlet weak var textview: UITextView!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return hit")
        textField.resignFirstResponder()
        return true
    }
    @IBAction func post(_ sender: Any) {
			if ((user) != nil){
				let key = ref?.child("Discussions").child(curClassID).child(self.discussion).child("Messages").childByAutoId().key
				ref?.child("Users").child((user?.uid)!).observe(.value, with : {(snapshot) in
					let nameDict = snapshot.value as! NSDictionary
					print (nameDict["DisplayName"])
					self.author = (nameDict["DisplayName"] as? String)!
					print("author is " + self.author)
					let post = ["uid": self.user?.uid,
				            "Author": self.author,
				            "Content": self.textview.text] as [String : Any]
					ref?.child("Discussions").child(curClassID).child(self.discussion).child("Messages").child(key!).updateChildValues(post)
				})
		}
	}

    override func viewDidLoad(){
        super.viewDidLoad()
		handle = Auth.auth().addStateDidChangeListener{(auth,us) in
			if us != nil{
				self.user = us
			}
		}
		self.discussion = Discussions[selectedDisc].key
        print("is running composer")
        self.textview.delegate = self
	}
}
