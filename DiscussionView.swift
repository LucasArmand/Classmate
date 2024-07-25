//
//  DiscussionView.swift
//  class
//
//  Created by Lucas Armand on 3/29/18.
//  Copyright © 2018 Lucas Armand. All rights reserved.
//

import Foundation
import UIKit
class DiscussionView : UIViewController{
    
    
    @IBOutlet weak var discussionName: UILabel!
    override func viewDidLoad() {
        discussionName.text = discussionNames[selectedDisc]
    }
}
