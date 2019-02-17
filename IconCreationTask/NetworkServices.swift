//
//  NetworkServices.swift
//  IconCreationTask
//
//  Created by Salma Hassan on 2/14/19.
//  Copyright © 2019 Salma Hassan. All rights reserved.
//

import Foundation
import Alamofire

class NetworkServices {
    
    typealias succussResult = (Any?) -> Void
    typealias failureResult = (Error?) -> Void
    
    class func signUp(userData : UserModel , success: succussResult? , failure : failureResult? ) {
        
        let param = ["lang" : "en",
                     "name" : userData.name,
                     "email" : userData.password,
                     "password" : userData.password,
                     "country_id" : userData.country,
                     "image" : userData.image ,
                     "token" : userData.token ,
                     "title" : userData.title
        ]
     
        guard let url = URL(string: "166.62.117.167/Comesa_app/mobileApp/signup.php") else {
            failure?(nil)
            return
        }
        
        Alamofire.request(url, method: .get, parameters: param ).validate().responseJSON { (response) in
            
            switch response.result {
            case .success(_):
                print("success")
                success?(nil)
            case .failure(_):
                print("fail")
                failure?(response.result.error)
                
            }
        }
    }
}
