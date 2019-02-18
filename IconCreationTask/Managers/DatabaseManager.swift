//
//  DatabaseManager.swift
//  IconCreationTask
//
//  Created by Salma Hassan on 2/18/19.
//  Copyright © 2019 Salma Hassan. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseManager {
    
    // Get the default Realm
    func realmInstance() -> Realm? {
        do {
            let realm = try Realm()
            return realm
        }catch{
            print("couldn't get realm instance => \(error.localizedDescription)")
        }
        
        return nil
    }
    
    
    static let sharedInstance = DatabaseManager()
    
    private init(){
        
    }
    
    func saveUser(user: UserModel){

        if let realm = realmInstance(){
            //delet any old data
            
//            deleteAll()
            let newUser = User()
            newUser.name = user.name
            newUser.email = user.email
            newUser.country = user.country
            newUser.password = user.password
            newUser.image = user.image
            newUser.lang = "en"
            newUser.token = ""
            newUser.title = ""
            
            // Persist your data easily
            try! realm.write {
                realm.add(newUser)
                print("realm => \(String(describing: realm.objects(User.self).first))")
            }
        }
        
    }
    
    func deleteAll() {
        if let realm = realmInstance() {
            realm.deleteAll()
        }
    }
    
    func getLoggedUser(){
        if let realm = realmInstance() {
            print("realm => \(String(describing: realm.objects(User.self).first))")
        }
    }
    
    func getUser() -> User? {
        if let realm = realmInstance() {
            return realm.objects(User.self).first
        }
        
        return nil
    }
    
    
}
