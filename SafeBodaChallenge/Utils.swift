//
//  Utils.swift
//  SafeBodaChallenge
//
//  Created by Rotem Nevgauker on 26/09/2019.
//  Copyright © 2019 Rotem Nevgauker. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class Utils: NSObject {
    
    class func saveToken(token:String)->Bool {
        let keychainWrapper = KeychainWrapper.standard
        let saveSuccessful: Bool = keychainWrapper.set(token, forKey:"token")
        return saveSuccessful
    }
    class func loadToken()->String? {
        let keychainWrapper = KeychainWrapper.standard

        let retrievedString: String? = keychainWrapper.string(forKey:"token")
        
        let defaults = UserDefaults.standard

        
        if let expired = defaults.object(forKey: "expired") as? Date {
            if  Date() > expired {
                return nil
            }
        }
        
        return retrievedString
        
    }
    class func removeToken(token:String)->Bool {
        let keychainWrapper = KeychainWrapper.standard
        let removeSuccessful: Bool = keychainWrapper.removeObject(forKey:"token")
        return removeSuccessful
    }
    
    
    
    class func convertDateFormatter(date: Date) -> String {
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let dateStr = df.string(from: date)
        return dateStr
        
        
    }
    
    class func serverdateSringToDisplay(dateStr:String)->String{
        let dateFormatter = DateFormatter()
        
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        let date = dateFormatter.date(from: dateStr)
        dateFormatter.dateFormat = "MM-dd HH:mm"

        
        let str = dateFormatter.string(from: date!)
        return str
        
        
        
        
    }
        
        
        
     



}
