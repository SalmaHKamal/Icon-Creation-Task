//
//  AgendaViewController.swift
//  IconCreationTask
//
//  Created by Salma Hassan on 2/15/19.
//  Copyright © 2019 Salma Hassan. All rights reserved.
//

import UIKit
import SnapKit
import Toast_Swift
import SwiftyJSON

class AgendaViewController : UIViewController {
    

    @IBOutlet weak var parentTableView: UITableView!
    @IBOutlet weak var noEventsView: UIView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    let refreshControl = UIRefreshControl()
    var eventName = "Introduction"
    var agendaArray = [AgendaModel]()
    var eventArray = [EventModel]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarView?.backgroundColor = satusBarColor
    }
    

    
    func showToast(msg : String){
        view.makeToast(msg, duration : 2.0 , position : .center )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initNavigationBar()
        
        parentTableView.delegate = self
        parentTableView.dataSource = self

        parentTableView.isHidden = true
        noEventsView.isHidden = false
        
        activityIndicatorView.isHidden = false
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
        
        getAgendaData()

        
        if #available(iOS 10.0, *) {
            parentTableView.refreshControl = refreshControl
        } else {
            parentTableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refreshAgendaData), for: .valueChanged)

    }
    

    
    @objc func refreshAgendaData(){
        agendaArray = []
        getAgendaData()
    }
    
    @objc func getAgendaData(){
        
        
        NetworkServices.getAgendaList(success: { (value) in
            if let result = value as? JSON {
                if result["status"] == "1" {
                    for agenda in result["data"]{
                        print("salma agenda => \(agenda)")
                        for event in agenda.1["data"] {
                            print("salma event for one agenda")
                            self.eventArray.append(EventModel(_id: event.1["id"].stringValue,
                                                         _title: event.1["title"].stringValue,
                                                         _timeFrom: event.1["time_from"].stringValue,
                                                         _timeTo: event.1["time_to"].stringValue ,
                                                         _trackId: event.1["track_id"].stringValue,
                                                         _addToCalender: event.1["adddedtocalender"].stringValue,
                                                         _date: event.1["date"].stringValue))
                        }
                        
                        self.agendaArray.append(AgendaModel(_id: agenda.1["id"].stringValue ,
                                                       _date: agenda.1["date"].stringValue ,
                                                       _events: self.eventArray))
                    }
                   
//                    self.eventName = result["data"][0]["data"][0]["title"].stringValue
                    self.showTable()
                    self.reloadData()
                    NotificationCenter.default.post(name: NSNotification.Name("updateCell"), object: nil , userInfo : ["agenda": self.agendaArray])
                }else{
                    self.showToast(msg: result["MessageText"].stringValue)
                }
            }
        }) { (error) in
            if let error = error {
                self.showToast(msg: error.localizedDescription)
            }else{
                self.showToast(msg: "verify that your information is correct or no internet connectivity")
            }
        }
    }
    
    
    @objc func reloadData(){
        parentTableView.reloadData()
    }
    
    @objc func showTable(){
        parentTableView.isHidden = false
        noEventsView.isHidden = true
        activityIndicatorView.startAnimating()
        refreshControl.endRefreshing()
    }
    


}



extension AgendaViewController : UITableViewDelegate , UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == parentTableView {
            print("salma")
            print("agenda count => \(agendaArray.count)")
            return agendaArray.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == parentTableView {
            let cell = parentTableView.dequeueReusableCell(withIdentifier: "agendaCell", for: indexPath) as! SingleAgendaCell
            cell.cellIndex = indexPath.row
            
            cell.dayNum.text = agendaArray[indexPath.row].date
//            print("index path => \(cell.cellIndex)")
            cell.tag = indexPath.row
//            cell.
//            cell.circleView.layer.cornerRadius = 4
//            cell.circleView.layer.masksToBounds = true
//            cell.dayNum.text = "salma"
//            cell.monthName.text = "hassan"
            cell.eventCardTable.reloadData()
//            if let c = cell.eventCardTable.cellForRow(at: indexPath) as? singleEventDetailsCell
//            {c.eventCard.timeLabel.text = "salmaaaa"}
            if indexPath.row != 0 {
//                cell.alignTopWithCircleView.isActive = false
//                cell.timelineTopConstraint.constant = 0
//                cell.timelineBottomSpace.constant = 0
            }
            return cell
            
        }

        return UITableViewCell()

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
    
    
}

extension AgendaViewController {
    
    func initNavigationBar() {
        //title
        navigationItem.title = "Agenda"
        let titleTxtAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white,
                                  NSAttributedString.Key.font : UIFont(name: "Century Gothic", size: 16)!]
        navigationController?.navigationBar.titleTextAttributes = titleTxtAttributes
        
        //right item
        let rightBtn = UIButton(type: .custom)
        rightBtn.addTarget(self, action: #selector(notifcationBtnClicked), for: .touchUpInside)
        rightBtn.setImage(#imageLiteral(resourceName: "notifications").withRenderingMode(.alwaysOriginal), for: .normal)
        rightBtn.translatesAutoresizingMaskIntoConstraints = false
        rightBtn.heightAnchor.constraint(equalToConstant: 25).isActive = true
        rightBtn.widthAnchor.constraint(equalToConstant: 25).isActive = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
       
        //left item
//        let leftBtn = UIButton(type: .custom)
//        leftBtn.addTarget(self, action: #selector(showMoreBtnClicked), for: .touchUpInside)
//        leftBtn.setImage(#imageLiteral(resourceName: "if_Menu1_1031511").withRenderingMode(.alwaysOriginal), for: .normal)
//        leftBtn.translatesAutoresizingMaskIntoConstraints = false
//        leftBtn.heightAnchor.constraint(equalToConstant: 15).isActive = true
//        leftBtn.widthAnchor.constraint(equalToConstant: 25).isActive = true
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
    }
    
    
    @objc func notifcationBtnClicked(){
        print("clciked")
    }
    
    @objc func showMoreBtnClicked(){

    }


}


