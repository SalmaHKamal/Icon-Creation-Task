//
//  NetworkServices.swift
//  IconCreationTask
//
//  Created by Salma Hassan on 2/14/19.
//  Copyright © 2019 Salma Hassan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkServices {
    
    typealias succussResult = (Any?) -> Void
    typealias failureResult = (Error?) -> Void
    
    class func signUp(userData : UserModel , success: succussResult? , failure : failureResult? ) {
        
        if Connectivity.isConnectedToInternet() {
            guard let url = URL(string: "http://166.62.117.167/Comesa_app/mobileApp/signup.php") else {
                failure?(nil)
                return
            }
            
            let param = ["lang" : userData.lang,
                         "name" : userData.name,
                         "email" : userData.email,
                         "password" : userData.password,
                         "country_id" : userData.country,
                         "image" : userData.image ,
                         "token" : userData.token ,
                         "title" : userData.title
            ]
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = try! JSONSerialization.data(withJSONObject: param, options: .prettyPrinted)
            
            Alamofire.request(request).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    success?(json)
                case .failure(let error):
                    failure?(error)
                }
            }
            
        }else{
            print("no network")
            failure?(nil)
        }
    }
    
    class func getCountriesList(success: succussResult? , failure : failureResult?){
        if Connectivity.isConnectedToInternet() {
            guard let url = URL(string: "http://166.62.117.167/Comesa_app/mobileApp/getCountriesList.php")
                else{
                    return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = try! JSONSerialization.data(withJSONObject: ["lang":"en"], options: .prettyPrinted)
            
            Alamofire.request(request).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    success?(json["data"])
                case .failure(let error):
                    failure?(error)
                }
                
            }
        }else{
            failure?(nil)
            print("no network")
        }
    }
    
    class func getAgendaList(success: succussResult? , failure : failureResult?){
        if Connectivity.isConnectedToInternet(){
            guard let url = URL(string: "http://166.62.117.167/Comesa_app/mobileApp/getAgenda.php")
                else{
                    return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = try! JSONSerialization.data(withJSONObject: ["lang":"en", "user_id":1], options: .prettyPrinted)
            
            Alamofire.request(request)
                .responseJSON { (response) in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        success?(json)
                    case .failure(let error):
                        failure?(error)
                    }
            }
        }else{
            failure?(nil)
        }
    }
    
    class func getSpeakersList(success: succussResult? , failure : failureResult?){
        if Connectivity.isConnectedToInternet(){
            guard let url = URL(string: "http://166.62.117.167/Comesa_app/mobileApp/getAgendaSpeakers.php")
                else{
                    return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = try! JSONSerialization.data(withJSONObject: ["lang":"en", "agenda_id": 1], options: .prettyPrinted)
            
            Alamofire.request(request)
                .responseJSON { (response) in
                    
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        success?(json)
                    case .failure(let error):
                        failure?(error)
                    }
            }
            
        }else{
            failure?(nil)
        }
    }
    
    
    class func addToCalender(success: succussResult? , failure : failureResult?){
        if Connectivity.isConnectedToInternet(){
            guard let url = URL(string: "http://166.62.117.167/Comesa_app/mobileApp/addToCalendar.php")
                else{
                    return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = try! JSONSerialization.data(withJSONObject: ["lang":"en",
                                                                            "user_id": "1",
                                                                            "agenda_id": "2",
                                                                            "adddedtocalender":"1"], options: .prettyPrinted)
            
            Alamofire.request(request)
                .responseJSON { (response) in
                    
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        success?(json)
                    case .failure(let error):
                        failure?(error)
                    }
            }
            
        }else{
            failure?(nil)
        }
    }
    
    
}


class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}


