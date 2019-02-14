//
//  SignUpCells.swift
//  IconCreationTask
//
//  Created by Salma Hassan on 2/14/19.
//  Copyright © 2019 Salma Hassan. All rights reserved.
//

import UIKit

class SignUpCell : UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userCountry: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userConfirmPass: UITextField!
    
    
    
    //MARK:- Actions
    @IBAction func signUp(_ sender: Any) {
        print("Salma")
    }
    
}
