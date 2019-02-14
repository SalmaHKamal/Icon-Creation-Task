//
//  learnVC.swift
//  IconCreationTask
//
//  Created by Salma Hassan on 2/14/19.
//  Copyright © 2019 Salma Hassan. All rights reserved.
//

import UIKit
import SearchTextField

class learnVC : UIViewController {
    
    
    @IBOutlet weak var country: SearchTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        country.filterStrings(["salma" , "hassan" , "kamal"])
        
        country.theme = SearchTextFieldTheme.darkTheme()
    }
}
