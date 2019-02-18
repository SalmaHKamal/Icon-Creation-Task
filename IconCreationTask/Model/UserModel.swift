//
//  UserModel.swift
//  IconCreationTask
//
//  Created by Salma Hassan on 2/14/19.
//  Copyright © 2019 Salma Hassan. All rights reserved.
//

import Foundation

class UserModel {
    
    var lang = "en"
    var image : String = ""
    var name : String = ""
    var email : String = ""
    var country : String = ""
    var password : String = ""
    var token = ""
    var title = ""
    
    init(_image : String , _name : String , _email : String , _country : String , _password : String) {
        image = _image
        name = _name
        email = _email
        country = _country
        password = _password
    }
}
