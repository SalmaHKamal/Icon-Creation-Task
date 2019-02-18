//
//  TimelineView.swift
//  IconCreationTask
//
//  Created by Salma Hassan on 2/15/19.
//  Copyright © 2019 Salma Hassan. All rights reserved.
//

import UIKit

class TimelineView: UIView {

    @IBOutlet weak var timelineView: UIView!
    
    override func awakeFromNib() {
        timelineView.backgroundColor = lineFillColor
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
