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
    
    override func awakeFromNib() {
        cardTopView.backgroundColor = lightGrayColor
        bottomCardView.backgroundColor = normalGrayColor
        addToCalenderLabel.textColor = blueThemeColor
        timeLabel.textColor = darkGrayColor
        cardView.layer.masksToBounds = true
        cardView.layer.cornerRadius = 10
    }

}
