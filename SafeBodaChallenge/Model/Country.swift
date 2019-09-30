//
//  Country.swift
//  SafeBodaChallenge
//
//  Created by Rotem Nevgauker on 28/09/2019.
//  Copyright © 2019 Rotem Nevgauker. All rights reserved.
//

import UIKit

struct Country {
    
    var countryCode:String = ""
    var name:[String : Any] = [String : Any]()
    
    init(data:[String : Any]) {
        if let val = data["CountryCode"] as? String {
            countryCode = val
        }
        if let names = data["Names"] as? [String :Any] {
            if let val = names["Name"] as? [String :Any] {
                name = val
            }else if let val = names["Name"] as? [[String :Any]] {
                if val.count > 0 {
                    name = val[0]
                }
            }
        }
        
    }


}
