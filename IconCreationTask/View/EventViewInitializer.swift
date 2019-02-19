//
//  EventViewInitializer.swift
//  IconCreationTask
//
//  Created by Salma Hassan on 2/19/19.
//  Copyright © 2019 Salma Hassan. All rights reserved.
//

import UIKit

class EventViewInitializer: UIView {
    
    var salm : String?
    
    override func awakeFromNib() {
        loadEventCard()
    }
    
    func updateViewWithData(agendaDate : [AgendaModel]) {
        
    }
    
    
    func loadEventCard() {
        if let eventCard = Bundle.main.loadNibNamed("EventCard", owner: self, options: nil)?.first as? EventCard {
            
            addSubview(eventCard)
    
            eventCard.snp.makeConstraints { (make) in
//                make.centerY.equalTo(self)
                make.top.equalTo(snp_topMargin)
                make.bottom.equalTo(snp_bottomMargin)
                make.leading.equalTo(snp_leadingMargin)
                make.trailing.equalTo(snp_trailingMargin)
            }
            
        }else{
            print("couldn't load event card")
        }
    }
}
