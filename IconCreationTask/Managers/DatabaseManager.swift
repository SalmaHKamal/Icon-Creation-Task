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
            
            deleteAll()
            let newUser = User()
            newUser.name = user.name
            newUser.email = user.email
            newUser.country = user.country
            newUser.password = user.password
            newUser.image = user.image
            newUser.lang = "en"
            newUser.token = ""
            newUser.title = ""
            
            
            try! realm.write {
                realm.add(newUser)
                print("realm => \(String(describing: realm.objects(User.self).first))")
            }
        }
        
    }
    
    func deleteAll() {
        if let realm = realmInstance() {
            try! realm.write {
                realm.deleteAll()
            }
            
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
    
//    func saveAgenda(data : [AgendaModel]) -> Bool {
//        if let realm = realmInstance() , realm.objects(User.self).count == 1 {
//            try? realm.write {
//                if let user = getUser() {
//                    user.agendas = List<Agenda>()
//                    for agenda in data {
//                        let agendaModel = Agenda()
//                        agendaModel.id = agenda.id ?? ""
//                        agendaModel.date = agenda.date ?? ""
//
//                        for event in agenda.events! {
//                            let eventModel = Event()
//                            eventModel.id = event.id ?? ""
//                            eventModel.addToCalender = event.addToCalender ?? "0"
//                            eventModel.date = event.date ?? ""
//                            eventModel.timeFrom = event.timeFrom ?? ""
//                            eventModel.timeTo = event.timeTo ?? ""
//                            eventModel.title = event.title ?? ""
//                            eventModel.trackId = event.trackId ?? ""
//
//                            agendaModel.events.append(eventModel)
//                        }
//
//                        user.agendas.append(agendaModel)
//                    }
//
//                    realm.add(user)
//                    print("realm => \(String(describing: realm.objects(User.self).first))")
//                }
//            }
//        }else {
//            return false
//        }
//
//        return false
//    }
    
    
    
    func updateAgendasWithUserID(listOfAgendas: [AgendaModel]) -> Bool{
        if let realm = realmInstance() , realm.objects(User.self).count == 1 , let user = getUser(){
            do{
                try realm.write {
                    for agenda in listOfAgendas {
                        let agendaModel = Agenda()
                        agendaModel.id = agenda.id ?? ""
                        agendaModel.date = agenda.date ?? ""
                        agendaModel.userId = user.id
                        
                        for event in agenda.events! {
                            let eventModel = Event()
                            eventModel.id = event.id ?? ""
                            eventModel.addToCalender = event.addToCalender ?? "0"
                            eventModel.date = event.date ?? ""
                            eventModel.timeFrom = event.timeFrom ?? ""
                            eventModel.timeTo = event.timeTo ?? ""
                            eventModel.title = event.title ?? ""
                            eventModel.trackId = event.trackId ?? ""
                            eventModel.agendaId = agenda.id
                            
                            realm.add(eventModel)
                            
                        }
                        
                        realm.add(agendaModel)
                    }
                }
                return true
            }catch{
                print("realm error => \(error.localizedDescription)")
                return false
            }
 
        }else{
            return false
        }
    }
    
}
