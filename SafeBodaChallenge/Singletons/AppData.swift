//
//  AppData.swift
//  SafeBodaChallenge
//
//  Created by Rotem Nevgauker on 27/09/2019.
//  Copyright © 2019 Rotem Nevgauker. All rights reserved.
//

import UIKit

class AppData: NSObject {
    
    static let shared = AppData()
    private var airports:[Airport] = [Airport]()
    
    private override init() { }
    func handleAirportsData(data:[[String : Any]]) {
        for airportData in data {
            let airport = Airport(data: airportData)
            airports.append(airport)
        }
    }
    func getAirports()->[Airport]{
        return airports
    }


}
