//
//  Airport.swift
//  SafeBodaChallenge
//
//  Created by Rotem Nevgauker on 27/09/2019.
//  Copyright © 2019 Rotem Nevgauker. All rights reserved.
//

import Foundation


struct Airport {
    var airportCode:String = ""
    var name:String = ""
    var latitude:Float = 0.0
    var longitude:Float = 0.0
    
    init(data:[String : Any]) {
        if let names  = data["Names"] as? [String : Any]{
            print(names.keys)
            if let val  = names["Name"] as? [[String : Any]]{
                print(val)
                name = val[0]["$"] as! String
            }
            
          
        }
        if let val  = data["AirportCode"] as? String{
            airportCode = val
        }
        
        if let position  = data["Position"] as? [String : Any]{
            if let coordinate  = position["Coordinate"] as? [String : Any]{
                if let val  = coordinate["Latitude"] as? Float{
                   latitude = val
                }
                if let val  = coordinate["Longitude"] as? Float{
                    longitude = val
                }
            
            }
            
        }
    }
}
            








