//
//  Event.swift
//  IconCreationTask
//
//  Created by Salma Hassan on 2/19/19.
//  Copyright © 2019 Salma Hassan. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Event : Object {
    
    dynamic var id = ""
    dynamic var title = ""
    dynamic var timeFrom = ""
    dynamic var timeTo  = ""
    dynamic var trackId = ""
    dynamic var addToCalender = ""
    dynamic var date = ""
    dynamic var agendaId : String?
    
//    override static func primaryKey() -> String? {
//        return "id"
//    }
}
