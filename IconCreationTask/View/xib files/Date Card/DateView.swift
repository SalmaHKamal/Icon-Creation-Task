//
//  DateView.swift
//  IconCreationTask
//
//  Created by Salma Hassan on 2/15/19.
//  Copyright © 2019 Salma Hassan. All rights reserved.
//

import UIKit

class DateView: UIView {
    
    @IBOutlet weak var dayNum: UILabel!
    @IBOutlet weak var monthValue: UILabel!
    @IBOutlet weak var circleView: UIView!
    
    override func awakeFromNib() {
        styleViews()
    }
    
    func styleViews(){
        dayNum.textColor = blueThemeColor
        monthValue.textColor = darkGrayColor
        circleView.layer.cornerRadius = 5
        circleView.backgroundColor = orangeColor
    }

}
