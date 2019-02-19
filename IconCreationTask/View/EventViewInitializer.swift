//
//  EventViewInitializer.swift
//  IconCreationTask
//
//  Created by Salma Hassan on 2/19/19.
//  Copyright © 2019 Salma Hassan. All rights reserved.
//

import UIKit

class EventViewInitializer: UIView {

    var eventCard : EventCard?
    override func awakeFromNib() {
        loadEventCard()
    }

    func loadEventCard() {
        if Bundle.main.loadNibNamed("EventCard", owner: self, options: nil)?.first as? EventCard != nil {
            
            guard let eventCard = Bundle.main.loadNibNamed("EventCard", owner: self, options: nil)?.first as? EventCard else {
                return
            }
            
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
    
    func updateData(data: EventModel) {
        if let card = eventCard {
            card.updateData(with: data)
        }
    }
}
