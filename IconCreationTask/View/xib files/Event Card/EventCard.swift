//
//  EventCard.swift
//  IconCreationTask
//
//  Created by Salma Hassan on 2/15/19.
//  Copyright © 2019 Salma Hassan. All rights reserved.
//

import UIKit

class EventCard: UIView {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardTopView: UIView!
    @IBOutlet weak var bottomCardView: UIView!
    @IBOutlet weak var addToCalenderLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var EventName: UILabel!

    @IBOutlet weak var addToCalenderImage: UIImageView!
    @IBOutlet weak var addToCalenderBtn : UIButton!
    
    @IBOutlet weak var eventTitle: UILabel!
    
    override func awakeFromNib() {
        cardTopView.backgroundColor = lightGrayColor
        bottomCardView.backgroundColor = normalGrayColor
        addToCalenderLabel.textColor = blueThemeColor
        timeLabel.textColor = darkGrayColor
        cardView.layer.masksToBounds = true
        cardView.layer.cornerRadius = 10
 
//        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "updateData"), object: nil, queue: nil, using: updateData)
    }
    
    
    
//    func updateData(notification:Notification){
//        guard let data = notification.userInfo!["event"] as? EventModel else {
//            return
//        }
//        
//        print("event data => \(data)")
//        timeLabel.text = "\(data.timeFrom ?? "") \(data.timeTo ?? "")"
//        eventTitle.text = data.title
//        if data.addToCalender == "0" {
//            addToCalenderLabel.text = "Added to calender"
//            addToCalenderBtn.setImage(#imageLiteral(resourceName: "tick-inside-a-circle"), for: .normal)
//        }else{
//            addToCalenderLabel.text = "Add to my calender"
//            addToCalenderBtn.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
//        }
//        
//    }

}
