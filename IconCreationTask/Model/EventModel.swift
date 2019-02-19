//
//  AgendaModel.swift
//  IconCreationTask
//
//  Created by Salma Hassan on 2/18/19.
//  Copyright © 2019 Salma Hassan. All rights reserved.
//

import Foundation
import ObjectMapper

class EventModel : Mappable {
    
    var id : String?
    var title : String?
    var timeFrom : String?
    var timeTo : String?
    var trackId : String?
    var addToCalender : String?
    var date : String?
    
    init() {
        
    }

    init(_id : String , _title : String , _timeFrom : String , _timeTo : String , _trackId : String , _addToCalender : String , _date : String) {
        id = _id
        title = _title
        timeFrom = _timeFrom
        timeTo = _timeTo
        trackId = _trackId
        addToCalender = _addToCalender
        date = _date
    }
    
    required init?(map: Map) {

    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        timeFrom <- map["time_from"]
        timeTo <- map["time_to"]
        trackId <- map["track_id"]
        addToCalender <- map["adddedtocalender"]
        date <- map["date"]
    }
    
    
}
