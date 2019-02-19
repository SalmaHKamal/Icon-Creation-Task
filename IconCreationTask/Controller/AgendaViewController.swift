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
    var eventCard : EventCard!
    
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
        
        parentTableView.estimatedRowHeight = 600
        parentTableView.rowHeight = UITableView.automaticDimension
        
        parentTableView.isHidden = true
        noEventsView.isHidden = true
        
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(refetchData), name: NSNotification.Name(rawValue: "refetchData"), object: nil)
        
    }
    
    @objc func refetchData(){
        refreshAgendaData()
    }
    
    func loadEventCard(){
        if Bundle.main.loadNibNamed("EventCard", owner: self, options: nil)?.first as? EventCard != nil {
            eventCard = Bundle.main.loadNibNamed("EventCard", owner: self, options: nil)?.first as? EventCard
        }else{
            print("couldn't load nib")
        }
    }
    
    @objc func refreshAgendaData(){
        
        getAgendaData()
    }
    
    @objc func getAgendaData(){
        
        
        NetworkServices.getAgendaList(success: { (value) in
            
            
            if let result = value as? JSON {
                var agendaResultArray = [AgendaModel]()
                if result["status"] == "1" {
                    
                    for agenda in result["data"]{
                        
                        var eventResultArray = [EventModel]()
                        for event in agenda.1["data"] {
                            
                            eventResultArray.append(EventModel(_id: event.1["id"].stringValue,
                                                               _title: event.1["title"].stringValue,
                                                               _timeFrom: event.1["time_from"].stringValue,
                                                               _timeTo: event.1["time_to"].stringValue ,
                                                               _trackId: event.1["track_id"].stringValue,
                                                               _addToCalender: event.1["adddedtocalender"].stringValue,
                                                               _date: event.1["date"].stringValue))
                        }
                        
                        agendaResultArray.append(AgendaModel(_id: agenda.1["id"].stringValue ,
                                                             _date: agenda.1["date"].stringValue ,
                                                             _events: eventResultArray))
                        
                        
                    }
                    
                    if agendaResultArray.count > 0 {
                        self.showTable()
                        self.reloadData(data: agendaResultArray)
                        self.saveDataInRealm(data : agendaResultArray)
                    }else{
                        self.noEventsView.isHidden = false
                    }
                    
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
    
    func saveDataInRealm(data : [AgendaModel]){
        DispatchQueue.global(qos: .userInteractive).async {
            if !DatabaseManager.sharedInstance.updateAgendasWithUserID(listOfAgendas: data) {
                DispatchQueue.main.async {
                    self.showToast(msg: "Something wrong happened!")
                }
            }
        }
    }
    
    
    func reloadData(data : [AgendaModel]){
        
        agendaArray = data
        for agenda in agendaArray {
            if let events = agenda.events {
                for event in events {
                    eventArray.append(event)
                }
            }
        }
        
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
        return agendaArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let sessionVC = mainStoryboard.instantiateViewController(withIdentifier: "sesstionVC") as? SessionViewController {
            
            sessionVC.selectedData = (agendaArray[indexPath.section],eventArray[indexPath.row])
            show(sessionVC, sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == parentTableView {
            if let events = agendaArray[section].events {
                return events.count
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == parentTableView {
            let cell = parentTableView.dequeueReusableCell(withIdentifier: "agendaCell", for: indexPath) as! SingleAgendaCell
            
//            let singleAgenda = agendaArray[indexPath.section]
            let singleEvent = agendaArray[indexPath.section].events![indexPath.row]
            cell.accessoryType = .none
            cell.selectionStyle = .none
            
            if singleEvent.addToCalender == "0" {
                cell.eventView.eventCard?.addToCalenderLabel.text = "Add to my calender"
                cell.eventView.eventCard?.addToCalenderImage.image = #imageLiteral(resourceName: "plus")
            }else{
                cell.eventView.eventCard?.addToCalenderLabel.text = "Added to calender"
                cell.eventView.eventCard?.addToCalenderImage.image = #imageLiteral(resourceName: "tick-inside-a-circle")
            }
            
//            cell.eventView.eventCard?.addToCalenderBtn.addTarget(self , action: #selector(addToCalender(event:)) , for: .touchUpInside)
            cell.eventView.eventCard?.EventName.text = singleEvent.title
            cell.eventView.eventCard?.timeLabel.text = "\(singleEvent.timeFrom ?? "" ) - \(singleEvent.timeTo ?? "")"
  
            if indexPath.row == 0 {
                cell.circleView.isHidden = false
                cell.timelineTopConstraint.constant = 60
                cell.dayNum.text = extrackDay(dateString: agendaArray[indexPath.section].date ?? "") //.events![indexPath.row].date ?? ""
                cell.monthName.text = getMonthName(dateString: agendaArray[indexPath.section].date ?? ""
                ) //.events![indexPath.row].date ?? ""
            } else {
                cell.monthName.text = ""
                cell.dayNum.text = ""
                cell.circleView.isHidden = true
                cell.timelineTopConstraint.constant = 0
            }
            return cell
        }
        
        return UITableViewCell()
        
    }
    
//    @objc func addToCalender(event : EventModel){
//        NetworkServices.addToCalender(success: { (res) in
//            if let response = res as? JSON {
//                if response["status"] == "1" {
//                    if self.event.addToCalender == "0" {
//                        event.addBtn.setImage(#imageLiteral(resourceName: "tick-inside-a-circle"), for: .normal)
//                        event.addToCalenderLbl.text = "Added to calender"
//                        event.selectedData.1.addToCalender = "1"
//                    }else{
//                        event.addBtn.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
//                        event.addToCalenderLbl.text = "Add to my calender"
//                        event.addToCalender = "0"
//                    }
//                }
//            }
//        }) { (error) in
//            if let error = error {
//                self.showToast(msg: error.localizedDescription)
//            }else{
//                self.showToast(msg: "verify that your information is correct or no internet connectivity")
//            }
//        }
//    }
    
    
    
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
    
    func extrackDay(dateString : String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let calender = Calendar.current
        return String(calender.component(.day, from: dateFormatter.date(from: dateString) ?? Date()))
    }
    
    //    func extrackDay(dateString : String?) -> String{
    //
    //        let dateFormatter = DateFormatter()
    //        let calender = Calendar.current
    //        guard let dateString = dateString else {
    //            return ""
    //        }
    //
    //        guard let formattedDate = dateFormatter.date(from: dateString) else {
    //            return ""
    //        }
    //        return String(calender.component(.day, from: formattedDate))
    //    }
    
    func getMonthName(dateString : String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let calender = Calendar.current
        let monthNum = calender.component(.month, from: dateFormatter.date(from: dateString) ?? Date())
        if monthNum > 0 {
            return DateFormatter().monthSymbols.remove(at: monthNum - 1)
        }
        return ""
    }
    
    //    func getMonthName(dateString : String?) -> String{
    //        let dateFormatter = DateFormatter()
    //        let calender = Calendar.current
    //
    //        guard let dateString = dateString , let formattedDate = dateFormatter.date(from: dateString) else {
    //            return ""
    //        }
    //
    //        let monthNum = calender.component(.month, from: formattedDate)
    //        if monthNum > 0 {
    //            return DateFormatter().monthSymbols.remove(at: monthNum - 1)
    //        }
    //
    //        return ""
    //    }
    
    
}
