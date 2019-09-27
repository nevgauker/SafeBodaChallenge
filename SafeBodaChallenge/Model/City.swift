//
//  City.swift
//  SafeBodaChallenge
//
//  Created by Rotem Nevgauker on 27/09/2019.
//  Copyright © 2019 Rotem Nevgauker. All rights reserved.
//

import UIKit

struct City {
    
    
    var cityCode:String = ""
    var countryCode:String = ""
    
    var airports:[String] = [String]()
    
    var name:[String : Any] = [String : Any]()
    
    init(data:[String : Any]) {
        
        if let val = data["CityCode"] as? String {
            cityCode = val
        }
        if let val = data["CountryCode"] as? String {
            countryCode = val
        }
        
      
        if let airports = data["Airports"] as? [String :Any] {
            if let val = airports["AirportCode"]  as? [String] {
                self.airports = val
            } else  if let val = airports["AirportCode"] as? String {
                self.airports.append(val)
            }
            
        }
        
        if let names = data["Names"] as? [String :Any] {
            if let val = names["Name"] as? [String :Any] {
                name = val
            }
        }
    }

}
