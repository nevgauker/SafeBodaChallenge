//
//  CountriesCache.swift
//  SafeBodaChallenge
//
//  Created by Rotem Nevgauker on 28/09/2019.
//  Copyright © 2019 Rotem Nevgauker. All rights reserved.
//

import UIKit

final class CountriesCache: NSObject {
    
    static let shared = CountriesCache()
    private var countries:[String : Country] = [String : Country]()
    
    private override init() { }
    
    func cacheSetup(arr:[Country]) {
        for c in arr {
            let str = c.countryCode
            countries[str] = c
        }
    }
    
    func countryByCode(countryCode:String)->Country? {
        return countries[countryCode]
    }

}
