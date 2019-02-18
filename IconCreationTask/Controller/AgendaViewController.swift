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
        getAgendaData()
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
        
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
        
        
        
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
                    for agenda in result["data"][0] {
                        for event in agenda.1 {
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == parentTableView {
            print("agenda count => \(agendaArray.count)")
            return agendaArray.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == parentTableView {
            let cell = parentTableView.dequeueReusableCell(withIdentifier: "agendaCell", for: indexPath) as! SingleAgendaCell
            cell.cellIndex = indexPath.row
            print("index path => \(cell.cellIndex)")
//            cell.
//            cell.circleView.layer.cornerRadius = 4
//            cell.circleView.layer.masksToBounds = true
//            cell.dayNum.text = "6"
//            cell.monthName.text = "Jan"
            if indexPath.row != 0 {
//                cell.alignTopWithCircleView.isActive = false
//                cell.timelineTopConstraint.constant = 0
//                cell.timelineBottomSpace.constant = 0
            }
            return cell
            
        }

        return UITableViewCell()
//        let cell = childTableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
//        return cell
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
//        navigationController.pus
//        navigationController?.show(SessionViewController(), sender: self)
//        present(SessionViewController(), animated: true, completion: nil)
//        navigationController?.pushViewController(SessionViewController(), animated: true)
    }
    
    func displayAgenda(){
        
//        let testView = UIView()
//        testView.backgroundColor = .red
//        contentView.addSubview(testView)
//
//        for _ in 0...20 {
//            let btn = UIButton()
//            testView.addSubview(btn)
//            btn.backgroundColor = .blue
//            btn.snp.makeConstraints { (mk) in
//                mk.height.width.equalTo(50)
//                mk.top.equalTo(btn)
//                mk.bottom.equalTo(testView.snp_bottomMargin)
//            }
//        }
//
//        testView.snp.makeConstraints { (make) in
//            make.width.equalTo(100)
//            make.bottom.equalTo(contentView.snp_bottomMargin)
//            make.top.equalTo(contentView.snp_topMargin)
//        }
  
//        if let timelineView = Bundle.main.loadNibNamed("TimelineView", owner: self, options: nil)?.first as? TimelineView {
//            contentView.addSubview(timelineView)
//            timelineView.snp.makeConstraints { (maker) in
//                maker.height.equalTo(1000)
//                maker.leading.equalTo(contentView.snp_leadingMargin)
//                maker.top.equalTo(contentView.snp_topMargin)
//                maker.bottom.equalTo(contentView.snp_bottomMargin)
//            }
//        }
//        guard let dateView = Bundle.main.loadNibNamed("DateView", owner: self, options: nil)?.first as? DateView,
//        let timelineView = Bundle.main.loadNibNamed("TimelineView", owner: self, options: nil)?.first as? TimelineView,
//        let eventCard = Bundle.main.loadNibNamed("EventCard", owner: self, options: nil)?.first as? EventCard
//        else {
//            displayEmptyView()
//            return
//        }
//
//        setViewsConstraints(views: timelineView , dateView , eventCard)
        
    }
    
//    func displayEmptyView(){}
    
//    func setViewsConstraints(views : UIView...){
//
//
//        for view in views {
//            self.view.addSubview(view)
//            view.translatesAutoresizingMaskIntoConstraints = false
//        }
//
//        let timelineView = views[0]
//        let dateView = views[1]
//        let eventView = views[2]
//
//        let dateLeading = dateView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.centeredView.leadingAnchor, multiplier: 1)
//        let dateTop = dateView.topAnchor.constraint(equalToSystemSpacingBelow: self.centeredView.topAnchor, multiplier: 1)
//
//        let timelineLeading = timelineView.leadingAnchor.constraint(equalTo: dateView.trailingAnchor, constant: -4)
//        let timelineTop = timelineView.topAnchor.constraint(equalToSystemSpacingBelow: self.centeredView.topAnchor, multiplier: 1)
//        let timelineHieght = timelineView.heightAnchor.constraint(equalToConstant: 10 * 100)
//        let timelineBottom = timelineView.bottomAnchor.constraint(equalTo: centeredView.bottomAnchor, constant: 16)
//
//        let eventLeading = eventView.leadingAnchor.constraint(equalTo: timelineView.trailingAnchor, constant: 10)
//        let eventTop = eventView.topAnchor.constraint(equalToSystemSpacingBelow: self.centeredView.topAnchor, multiplier: 1)
//        let eventHeight = eventView.heightAnchor.constraint(equalToConstant: 150)
//        let eventWidth = eventView.widthAnchor.constraint(equalToConstant: 400)
//
//        NSLayoutConstraint.activate([dateLeading , dateTop , timelineLeading , timelineTop , timelineHieght, eventLeading , eventTop , timelineBottom , eventWidth , eventHeight])
//
//
////        let newView = UIView()
////        newView.backgroundColor = UIColor.red
////        view.addSubview(newView)
////
////        newView.translatesAutoresizingMaskIntoConstraints = false
////        let horizontalConstraint = newView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
////        let verticalConstraint = newView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
////        let widthConstraint = newView.widthAnchor.constraint(equalToConstant: 100)
////        let heightConstraint = newView.heightAnchor.constraint(equalToConstant: 100)
////        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
//    }

}


