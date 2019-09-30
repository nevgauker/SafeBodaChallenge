//
//  CityTableViewCell.swift
//  SafeBodaChallenge
//
//  Created by Rotem Nevgauker on 27/09/2019.
//  Copyright © 2019 Rotem Nevgauker. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityCountryCodesLabel: UILabel!
    @IBOutlet weak var numverOfAirportsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupGUI() {
        containerView.layer.cornerRadius = 15.0
        containerView.clipsToBounds = true
        containerView.layer.borderWidth = 0.5
        containerView.layer.borderColor = UIColor.lightGray.cgColor
       

    }
    func updateData(city:City){
        nameLabel.text = city.name["$"] as? String
        cityCountryCodesLabel.text = city.countryCode
        if let country = CountriesCache.shared.countryByCode(countryCode: city.countryCode){
            if let name = country.name["$"] as? String {
                cityCountryCodesLabel.text = name
            }
        }
        
        let aitportsCount = city.airports.count
        
        if aitportsCount  ==  0 {
            numverOfAirportsLabel.text = "There are no airports in this city! "
        } else if aitportsCount  ==  1 {
            numverOfAirportsLabel.text = "There is one airport in this city : \(city.airports[0]) "
        } else {
            numverOfAirportsLabel.text = "There are \(aitportsCount) airport in this city."
        }
    }
        
}
