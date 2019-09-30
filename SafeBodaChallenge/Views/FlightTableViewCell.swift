//
//  FlightTableViewCell.swift
//  SafeBodaChallenge
//
//  Created by Rotem Nevgauker on 28/09/2019.
//  Copyright © 2019 Rotem Nevgauker. All rights reserved.
//

import UIKit

class FlightTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeOfDepartureLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var arivalTimeLabel: UILabel!
    
    @IBOutlet weak var airlineNameLabel: UILabel!
    @IBOutlet weak var flightNumberLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateData(flight:Flight){
        
        airlineNameLabel.text = "Airline : \(flight.airlineID)"
        flightNumberLabel.text = "Flight number : \(flight.flightNumber)"
        timeOfDepartureLabel.text = flight.departure.scheduledTimeLocal
        fromLabel.text =  flight.departure.airportCode
        
        arivalTimeLabel.text = flight.arrival.scheduledTimeLocal
        toLabel.text =  flight.arrival.airportCode
        
        
        
        
    
    }
    
}
