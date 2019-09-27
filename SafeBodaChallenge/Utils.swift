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
        return retrievedString
        
    }
    class func removeToken(token:String)->Bool {
        let keychainWrapper = KeychainWrapper.standard
        let removeSuccessful: Bool = keychainWrapper.removeObject(forKey:"token")
        return removeSuccessful
    }


}
