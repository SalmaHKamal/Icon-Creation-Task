//
//  AgendaViewController.swift
//  IconCreationTask
//
//  Created by Salma Hassan on 2/15/19.
//  Copyright © 2019 Salma Hassan. All rights reserved.
//

import UIKit
import SnapKit

class SingleAgendaCell : UITableViewCell , UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventCardTable.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! singleEventDetailsCell
        return cell
    }
    
    
    @IBOutlet weak var eventCardTable : UITableView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dayNum: UILabel!
    @IBOutlet weak var monthName: UILabel!
    @IBOutlet weak var circleView: UIView!
    
    override func awakeFromNib() {
        circleView.layer.cornerRadius = 4
        circleView.layer.masksToBounds = true
        dayNum.text = "6"
        monthName.text = "Jan"
        eventCardTable.delegate = self
        eventCardTable.dataSource = self
    }
}

class singleEventDetailsCell : UITableViewCell {
    
    override func awakeFromNib() {
        if  let eventCard = Bundle.main.loadNibNamed("EventCard", owner: self, options: nil)?.first as? EventCard {
            addSubview(eventCard)
        }else{
            print("couldn't load event card")
        }
    }
    
}

class AgendaViewController : UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var centeredView: UIView!
    @IBOutlet weak var parentTableView: UITableView!
    
    @IBOutlet weak var childTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initNavigationBar()
        
        parentTableView.delegate = self
        parentTableView.dataSource = self
//        displayAgenda()
    }

}

extension AgendaViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == parentTableView {
            return 2
        }
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == parentTableView {
            let cell = parentTableView.dequeueReusableCell(withIdentifier: "agendaCell", for: indexPath) as! SingleAgendaCell
//            cell.circleView.layer.cornerRadius = 4
//            cell.circleView.layer.masksToBounds = true
//            cell.dayNum.text = "6"
//            cell.monthName.text = "Jan"
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
        guard let dateView = Bundle.main.loadNibNamed("DateView", owner: self, options: nil)?.first as? DateView,
        let timelineView = Bundle.main.loadNibNamed("TimelineView", owner: self, options: nil)?.first as? TimelineView,
        let eventCard = Bundle.main.loadNibNamed("EventCard", owner: self, options: nil)?.first as? EventCard
        else {
            displayEmptyView()
            return
        }

        setViewsConstraints(views: timelineView , dateView , eventCard)
        
    }
    
    func displayEmptyView(){}
    
    func setViewsConstraints(views : UIView...){
        
        
        for view in views {
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        let timelineView = views[0]
        let dateView = views[1]
        let eventView = views[2]

        let dateLeading = dateView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.centeredView.leadingAnchor, multiplier: 1)
        let dateTop = dateView.topAnchor.constraint(equalToSystemSpacingBelow: self.centeredView.topAnchor, multiplier: 1)

        let timelineLeading = timelineView.leadingAnchor.constraint(equalTo: dateView.trailingAnchor, constant: -4)
        let timelineTop = timelineView.topAnchor.constraint(equalToSystemSpacingBelow: self.centeredView.topAnchor, multiplier: 1)
        let timelineHieght = timelineView.heightAnchor.constraint(equalToConstant: 10 * 100)
        let timelineBottom = timelineView.bottomAnchor.constraint(equalTo: centeredView.bottomAnchor, constant: 16)

        let eventLeading = eventView.leadingAnchor.constraint(equalTo: timelineView.trailingAnchor, constant: 10)
        let eventTop = eventView.topAnchor.constraint(equalToSystemSpacingBelow: self.centeredView.topAnchor, multiplier: 1)
        let eventHeight = eventView.heightAnchor.constraint(equalToConstant: 150)
        let eventWidth = eventView.widthAnchor.constraint(equalToConstant: 400)

        NSLayoutConstraint.activate([dateLeading , dateTop , timelineLeading , timelineTop , timelineHieght, eventLeading , eventTop , timelineBottom , eventWidth , eventHeight])
        
        
//        let newView = UIView()
//        newView.backgroundColor = UIColor.red
//        view.addSubview(newView)
//
//        newView.translatesAutoresizingMaskIntoConstraints = false
//        let horizontalConstraint = newView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        let verticalConstraint = newView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        let widthConstraint = newView.widthAnchor.constraint(equalToConstant: 100)
//        let heightConstraint = newView.heightAnchor.constraint(equalToConstant: 100)
//        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }

}


