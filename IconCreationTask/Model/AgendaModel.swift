//
//  AgendaModel.swift
//  IconCreationTask
//
//  Created by Salma Hassan on 2/18/19.
//  Copyright © 2019 Salma Hassan. All rights reserved.
//

import Foundation
import ObjectMapper

class AgendaModel : Mappable {
    
    var id : String?
    var date : String?
    var events : [EventModel]?
    
    required init?(map: Map) {
        
    }
    
    init(_id : String , _date : String , _events : [EventModel]) {
        id = _id
        date = _date
        events = _events
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        date <- map["date"]
        events <- map["data"]
    }
    
    
    
}
