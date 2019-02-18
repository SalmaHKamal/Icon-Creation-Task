//
//  File.swift
//  IconCreationTask
//
//  Created by Salma Hassan on 2/18/19.
//  Copyright © 2019 Salma Hassan. All rights reserved.
//

import UIKit

class singleEventDetailsCell : UITableViewCell {
    
    @IBOutlet weak var cellContentView: UIView!
    var eventCard : EventCard!
    override func awakeFromNib() {
        
        if Bundle.main.loadNibNamed("EventCard", owner: self, options: nil)?.first as? EventCard != nil {
            eventCard = Bundle.main.loadNibNamed("EventCard", owner: self, options: nil)?.first as? EventCard
            cellContentView.addSubview(eventCard)
            eventCard.EventName.text = ""
            
            NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "updateCell"), object: nil, queue: nil, using: updateCell)
            //.addObserver(self, selector: #selector(updateCell), name: NSNotification.Name(rawValue: "updateCell"), object: nil)
            
            
        }else{
            print("couldn't load event card")
        }
        
        
    }
    
    func updateCell(notification:Notification) {
        guard let agendaArray = notification.userInfo!["agenda"] as? [AgendaModel] else { return }
        
//        for agenda in agendaArray {
//            if let events = agenda.events {
//                for event in events {
//                    if event.addToCalender == "0" {
//                        eventCard.addToCalenderLabel.text = "Add to my calender"
//                    }else{
//                        eventCard.addToCalenderLabel.text = "Added to calender"
//                    }
//                    eventCard.timeLabel.text = "salma"//"\(event.timeFrom ?? "") - \(event.timeTo ?? "")"
//                }
//            }
//
//        }
        
    }
    
}

