//
//  tabBarControl.swift
//  class
//
//  Created by Lucas Armand on 3/28/18.
//  Copyright © 2018 Lucas Armand. All rights reserved.
//

import Foundation
import UIKit

class tabBarControl:UITabBarController{
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.selectedIndex = 1
        print ("i selected it")
    }
}
