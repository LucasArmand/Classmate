//
//  PasskeyCheck.swift
//  class
//
//  Created by Lucas Armand on 3/29/18.
//  Copyright © 2018 Lucas Armand. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class PasskeyCheck: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var textfield: UITextField!

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textfield.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad(){
        self.textfield.delegate = self
    }
    @IBAction func submit(_ sender: Any) {
        print("Guessing",CurClassPasskey)
        if (textfield.text == CurClassPasskey){
            self.performSegue(withIdentifier: "fromPasskey",sender: self)
        }else{
            textfield.text = ""
            titleText.text = "Wrong. Try Again"
        }
    }
    
}
