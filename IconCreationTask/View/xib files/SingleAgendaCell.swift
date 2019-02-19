//
//  File.swift
//  IconCreationTask
//
//  Created by Salma Hassan on 2/18/19.
//  Copyright © 2019 Salma Hassan. All rights reserved.
//

import UIKit

class SingleAgendaCell : UITableViewCell { //, UITableViewDataSource , UITableViewDelegate
    
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dayNum: UILabel!
    @IBOutlet weak var monthName: UILabel!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var alignTopWithCircleView: NSLayoutConstraint!
    @IBOutlet weak var timelineTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var eventView: EventViewInitializer!
    
    @IBOutlet weak var timelineBottomSpace: NSLayoutConstraint!

    var agendaArray = [AgendaModel]()

    
    override func awakeFromNib() {
        circleView.layer.cornerRadius = 4
        circleView.layer.masksToBounds = true
        circleView.backgroundColor = orangeColor
        dayNum.text = "6"
        monthName.text = "Jan"
    }
    
    
//    func updateData(data: EventModel) {
////        if let eventView = eventView {
//            eventView.updateData(data: data)
////        eventView.eventCard?.EventName.text = "salam"
////        }
//    }
 
}
