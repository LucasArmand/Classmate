//
//  ClassMainView.swift
//  class
//
//  Created by Lucas Armand on 8/4/17.
//  Copyright © 2017 Lucas Armand. All rights reserved.
//

import UIKit
import FirebaseAuthUI
import FirebaseAuth
import Firebase


class ClassMainView : UIViewController {
    
    
    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var classDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Classname",curClassName, curClassDesc)
        self.className.text = curClassName
        if(curClassSchool != "Nil"){
            self.classDescription.text = curClassDesc + " @ " + curClassSchool
        }else{
          self.classDescription.text = curClassDesc
        }
    }
}
