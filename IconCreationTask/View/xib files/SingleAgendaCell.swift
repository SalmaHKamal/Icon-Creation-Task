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
    @IBOutlet weak var eventView: UIView!
    
    @IBOutlet weak var timelineBottomSpace: NSLayoutConstraint!

    var agendaArray = [AgendaModel]()

    
    override func awakeFromNib() {
        circleView.layer.cornerRadius = 4
        circleView.layer.masksToBounds = true
        circleView.backgroundColor = orangeColor
        dayNum.text = "6"
        monthName.text = "Jan"
        //        dateView.isHidden = true
        //        circleView.isHidden = true
        //        alignTopWithCircleView.isActive = false
        //        timelineTopConstraint.constant = 0
        //
//        eventCardTable.delegate = self
//        eventCardTable.dataSource = self
        
//        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "updateCell"), object: nil, queue: nil, using: updateCell)
        
        //        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(rawValue: "reloadData"), object: nil)
    }
    
    
//    func updateCell(notification : Notification){
//
//        guard let array = notification.userInfo!["agenda"] as? [AgendaModel] else { return }
//
//        for agenda in array {
////            if let events = agenda.events {
////                for event in events {
//                    agendaArray.append(agenda)
////                }
////            }
//
//        }
//
////        eventCardTable.reloadData()
//
//    }
    
    //    @objc func reloadData(){
    //        eventCardTable.reloadData()
    //    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        for agenda in agendaArray{
//            if let events = agenda.events {
//                print("count => \(events.count)")
//                return events.count
//            }
//        }
//
//        print(cellIndex)
//
////        if let cellIndex = cellIndex , let count = agendaArray[cellIndex].events?.count {
////            return count
////        }
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = eventCardTable.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! singleEventDetailsCell
//        for agenda in agendaArray {
//            if let event = agenda.events {
//                if event[indexPath.row].addToCalender == "0" {
//                    cell.eventCard.addToCalenderLabel.text = "Add to my calender"
////                    cell.eventCard .
//                }else{
//                    cell.eventCard.addToCalenderLabel.text = "Added to calender"
//                }
//                cell.eventCard.timeLabel.text = "\(event[indexPath.row].timeFrom ?? "") - \(event[indexPath.row].timeTo ?? "")"
//                cell.eventCard.EventName.text =  event[indexPath.row].title
//                dayNum.text = extrackDay(dateString : event[indexPath.row].date ?? "")
//                monthName.text = getMonthName(dateString : event[indexPath.row].date ?? "")
//                cell.accessoryType = .none
//            }
//        }
//
//        return cell
//    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let sessionVC = mainStoryboard.instantiateViewController(withIdentifier: "agendaVC")
//        UINavigationController.pushViewController(sessionVC)
//    }
    


}
