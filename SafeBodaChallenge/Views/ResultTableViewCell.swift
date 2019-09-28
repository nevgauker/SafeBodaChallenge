//
//  ResultTableViewCell.swift
//  SafeBodaChallenge
//
//  Created by Rotem Nevgauker on 25/09/2019.
//  Copyright © 2019 Rotem Nevgauker. All rights reserved.
//

import UIKit



extension ResultTableViewCell : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let flight:Flight = flights[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellTypeAndIdentifier) as! FlightTableViewCell
        cell.updateData(flight: flight)
        return cell
        
    }
    
    
}
class ResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var flightsTableView: UITableView!
    
    let cellTypeAndIdentifier = "FlightTableViewCell"
    var flights:[Flight] = [Flight]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        flightsTableView.register(UINib(nibName: cellTypeAndIdentifier, bundle: nil), forCellReuseIdentifier: cellTypeAndIdentifier)
    }

  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupGUI() {
        flightsTableView.rowHeight = 50.0
        containerView.layer.cornerRadius = 15.0
        containerView.clipsToBounds = true
        containerView.layer.borderWidth = 0.5
        containerView.layer.borderColor = UIColor.lightGray.cgColor
    }
    func updateData(scedual:Schedule){
        flights.removeAll()
        flights.append(contentsOf: scedual.flights)
        flightsTableView.reloadData()
    }

}
