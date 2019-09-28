//
//  Schedule.swift
//  SafeBodaChallenge
//
//  Created by Rotem Nevgauker on 28/09/2019.
//  Copyright © 2019 Rotem Nevgauker. All rights reserved.
//

import UIKit


struct Departure {
    var airportCode:String = ""
    var terminal:String = ""
    var scheduledTimeLocal:String = ""
    
    init(data:[String : Any]) {
        
        if let  val = data["AirportCode"] as? String {
            airportCode = val
        }
        if let  val = data["Terminal"] as? String {
            terminal = val
        }
        
        if let scheduledTimeLocal = data["ScheduledTimeLocal"] as? [String :  Any] {
            if let val = scheduledTimeLocal["DateTime"] as? String {
                self.scheduledTimeLocal = val
            }
        }
        
    }

}
struct Arrival {
    var airportCode:String = ""
    var terminal:String = ""
    var scheduledTimeLocal:String = ""
    init(data:[String : Any]) {
        if let  val = data["AirportCode"] as? String {
            airportCode = val
        }
        if let  val = data["Terminal"] as? String {
            terminal = val
        }
        
        if let scheduledTimeLocal = data["ScheduledTimeLocal"] as? [String :  Any] {
            if let val = scheduledTimeLocal["DateTime"] as? String {
                self.scheduledTimeLocal = val
            }
        }
    }
}

struct Flight {
    var departure:Departure!
    var arrival:Arrival!
    var airlineID:String = ""
    var flightNumber:Int = -1
    var stopQuantity:Int = -1
    
    init(data:[String : Any]) {
        if let val = data["Departure"] as? [String : Any] {
            let departure = Departure(data: val)
            self.departure = departure
        }
        if let val = data["Arrival"] as? [String : Any] {
            let arrival = Arrival(data: val)
            self.arrival = arrival
        }
        
        
        if let marketingCarrier = data["MarketingCarrier"] as? [String : Any] {
            if let val = marketingCarrier["AirlineID"] as? String {
                airlineID = val
            }
            if let val = marketingCarrier["FlightNumber"] as? Int {
                flightNumber = val
            }
        }

        if let details = data["Details"] as? [String : Any] {
            if let stops = details["Stops"] as?  [String : Any] {
                if let val = stops["StopQuantity"] as?  Int {
                    stopQuantity = val
                }
            }
        }
        
        
    }

}
struct Schedule {
    
    var flights:[Flight] = [Flight]()
    var duration:String = ""
   
    init(data:[String : Any]) {
        
        if let val = data["Flight"] as? [[String : Any]] {
            //multi leg flight
            for data in val {
                let flight = Flight(data: data)
                flights.append(flight)
            }
            

        }else if let val = data["Flight"] as? [String : Any] {
            let flight = Flight(data: val)
            flights.append(flight)
        }
        
        
        
       // if let schedule = data["Schedule"] as? [String : Any] {
            if let totalJourney = data["TotalJourney"] as? [String : Any] {
                if let val = totalJourney["Duration"] as? String {
                    duration = val
                }
            }
    }
}
