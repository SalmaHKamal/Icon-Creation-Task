//
//  User.swift
//  IconCreationTask
//
//  Created by Salma Hassan on 2/18/19.
//  Copyright © 2019 Salma Hassan. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class User : Object {
    dynamic var id = ""
    dynamic var name = ""
    dynamic var email = ""
    dynamic var password = ""
    dynamic var country = ""
    dynamic var lang = ""
    dynamic var image = ""
    dynamic var token = ""
    dynamic var title = ""
    dynamic var agendas = List<Agenda>()
 
//    override static func primaryKey() -> String? {
//        return "id"
//    }
}
