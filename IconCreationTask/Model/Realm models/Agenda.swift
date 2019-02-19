//
//  Agenda.swift
//  IconCreationTask
//
//  Created by Salma Hassan on 2/19/19.
//  Copyright © 2019 Salma Hassan. All rights reserved.
//

import Foundation

import RealmSwift

@objcMembers class Agenda : Object {
    dynamic var id = "0"
    dynamic var date = ""
    @objc dynamic var userId : String?
//    dynamic let events = List<Event>()
    
//    override static func primaryKey() -> String? {
//        return "id"
//    }
}

