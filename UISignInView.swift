//
//  UISignInView.swift
//  class
//
//  Created by Lucas Armand on 3/15/18.
//  Copyright © 2018 Lucas Armand. All rights reserved.
//

import Firebase
import FirebaseAuthUI
import UIKit
import FirebaseAuth

var ref:DatabaseReference!
var observers:[DatabaseHandle] = []
class UISignInView : UIViewController {

    
    @IBOutlet weak var continueButton: UIButton!
    var handle: AuthStateDidChangeListenerHandle!
    @IBOutlet weak var text: UILabel!
    var authViewController:UINavigationController!
    
    override func viewDidLoad(){
        ref = Database.database().reference()
        //FirebaseApp.configure()
        let authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = nil
        
        print("!@&*^#$% IM RUNNING FINE !*&@#^%")
        authViewController = authUI!.authViewController()
        
    }
    @IBAction func button(_ sender: Any) {
        present(authViewController, animated: true,completion: nil)
    }
    
    override func viewWillAppear(_ animated:Bool = true) {
        handle = Auth.auth().addStateDidChangeListener{(auth,user) in
            if ((user) != nil){
                
            let uid = user?.uid
            print(uid!)
            print(ref)
            ref?.child("Users").child(uid!).child("DisplayName").observe(.value, with : {(snapshot) in
                print(snapshot.value)
                if let name = snapshot.value as? String? {
                    print(snapshot.value as! String?)
                    self.continueButton.isEnabled = true
                    self.text.text = "Welcome, " + name!
                }else{
                    
                    ref?.child("Users").child(uid!).child("DisplayName").setValue("User" + String(arc4random_uniform(9999)))
                    self.text.text = "Welcome! Set your display name in the Account tab"

                }
            })
            }
            else{
                self.continueButton.isEnabled = false
            }
            
        }
      
    }
    /*override func viewWillDisappear(_ animated: Bool) {
        do{
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out")
        }
    }
 */
}
