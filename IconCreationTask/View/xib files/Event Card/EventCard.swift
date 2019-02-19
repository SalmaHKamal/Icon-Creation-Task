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
    @IBOutlet weak var addToCalenderBtn: UIButton!
   
    override func awakeFromNib() {
        cardTopView.backgroundColor = lightGrayColor
        bottomCardView.backgroundColor = normalGrayColor
        addToCalenderLabel.textColor = blueThemeColor
        timeLabel.textColor = darkGrayColor
        cardView.layer.masksToBounds = true
        cardView.layer.cornerRadius = 10
    }

    @IBAction func addToCalenderAction(_ sender: Any) {
        
        
//        func addEventToCalender() {
//            NetworkServices.addToCalender(success: { (res) in
//                if let response = res as? JSON {
//                    if response["status"] == "1" {
//                        if self.added {
//                            self.addBtn.setImage(#imageLiteral(resourceName: "tick-inside-a-circle"), for: .normal)
//                            self.addToCalenderLbl.text = "Added to calender"
//                        }else{
//                            self.addBtn.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
//                            self.addToCalenderLbl.text = "Add to my calender"
//                        }
//                        self.added = !self.added
//                    }
//                }
//            }) { (error) in
//                if let error = error {
//                    self.showToast(msg: error.localizedDescription)
//                }else{
//                    self.showToast(msg: "verify that your information is correct or no internet connectivity")
//                }
//            }
//
//        }
    }
}
