//
//  ResultsViewController.swift
//  SafeBodaChallenge
//
//  Created by Rotem Nevgauker on 25/09/2019.
//  Copyright © 2019 Rotem Nevgauker. All rights reserved.
//

import UIKit
extension ResultsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sceduals.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell") as! ResultTableViewCell
        cell.setupGUI()
        let scedual = sceduals[indexPath.row]
        cell.updateData(scedual:scedual)
        return cell
    }
}
extension ResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // performSegue(withIdentifier: "mapSegue", sender: self)
    }
    
}

class ResultsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    
    var sceduals:[Schedule] = [Schedule]()
    let dateToFetch:Date = Date()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 200.0
        fetchSceduals()
    }
    
    
    func fetchSceduals() {
        let dateStr =  Utils.convertDateFormatter(date: dateToFetch)
        if LufthansaAPI.shared.needToFetchToken() {
            LufthansaAPI.shared.fetchSchedules(origin: "AMS", destination: "TXL", fromdate: dateStr, completion: { error,schedules in
                self.handleRespose(error: error, schedules: schedules)
            })
        }else {
            LufthansaAPI.shared.fetchSchedules(origin: "AMS", destination: "TXL", fromdate: dateStr, completion: { error,schedules in
                self.handleRespose(error: error, schedules: schedules)
            })
        }
    }
    
    func handleRespose(error:String?,schedules:[Schedule]?){
        if error != nil {
            //handle error
        }else {
            if let arr = schedules {
                self.sceduals.removeAll()
                self.sceduals.append(contentsOf: arr)
                self.tableView.reloadData()
            }
        }
        
    }
    
}
