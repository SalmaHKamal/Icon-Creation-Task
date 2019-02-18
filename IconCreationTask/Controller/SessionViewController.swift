//
//  SesstionTableViewController.swift
//  IconCreationTask
//
//  Created by Salma Hassan on 2/15/19.
//  Copyright © 2019 Salma Hassan. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON
import Toast_Swift

class speakerCell: UITableViewCell {
    
    @IBOutlet weak var speakerImage: UIImageView!
    @IBOutlet weak var speakerName: UILabel!
    @IBOutlet weak var speakerTitle: UILabel!
    
}

class SessionViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var addToCalenderLbl: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var speakersLabel: UILabel!
    
    var speakersArray = [[String:String]]()
    var added = false
    
    @IBAction func addToCalender(_ sender: Any) {
        
        NetworkServices.addToCalender(success: { (res) in
            if let response = res as? JSON {
                if response["status"] == "1" {
                    if self.added {
                        self.addBtn.setImage(#imageLiteral(resourceName: "tick-inside-a-circle"), for: .normal)
                        self.addToCalenderLbl.text = "Added to calender"
                    }else{
                        self.addBtn.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
                        self.addToCalenderLbl.text = "Add to my calender"
                    }
                    self.added = !self.added
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        customizeNavBar()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.estimatedRowHeight = 600
        getListOfSpeakers()
        addToCalenderLbl.textColor = blueThemeColor
        speakersLabel.textColor = blueThemeColor
    }
    
    func getListOfSpeakers(){
        NetworkServices.getSpeakersList(success: { (res) in
            if let speakers = res as? JSON {
                if speakers["status"] == "1" {
                
                    for speaker in speakers["data"] {
                        self.speakersArray.append(["id": speaker.1["id"].stringValue,
                                              "type" : speaker.1["ityped"].stringValue,
                                              "title" : speaker.1["title"].stringValue,
                                              "image" : speaker.1["image"].stringValue,
                                              "name" : speaker.1["name"].stringValue,
                                              "bio" : speaker.1["bio"].stringValue])
                    }
                    
                    DispatchQueue.main.async {
                        self.mainTableView.reloadData()
                    }
                }else{
                    self.showToast(msg: speakers["MessageText"].stringValue)
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
    
    func showToast(msg : String){
        view.makeToast(msg, duration : 2.0 , position : .center )
    }
    
    func customizeNavBar() {

        //title
        navigationItem.title = "Session"
        let titleTxtAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white,
                                  NSAttributedString.Key.font : UIFont(name: "Century Gothic", size: 16)!]
        navigationController?.navigationBar.titleTextAttributes = titleTxtAttributes
        
        //back
        let backBtn = UIButton(type: .custom)
        backBtn.addTarget(self, action: #selector(backBtnClicked), for: .touchUpInside)
        backBtn.setImage(#imageLiteral(resourceName: "back (2)").withRenderingMode(.alwaysOriginal), for: .normal)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.heightAnchor.constraint(equalToConstant: 25).isActive = true
        backBtn.widthAnchor.constraint(equalToConstant: 20).isActive = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
    }

    @objc func backBtnClicked(){
        navigationController?.popViewController(animated: true)
    }
    
}

extension SessionViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return speakersArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "speakerCell", for: indexPath) as! speakerCell
        
        cell.speakerName.text = speakersArray[indexPath.row]["name"]
        cell.speakerTitle.text = speakersArray[indexPath.row]["title"]
//        if let imageName = speakersArray[indexPath.row]["image"]{
//           cell.speakerImage.image = UIImage(named:imageName)
//        }else{
            cell.speakerImage.image = #imageLiteral(resourceName: "man")
//        }

        return cell
    }
    
    
}
