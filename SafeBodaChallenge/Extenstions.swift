//
//  Extenstions.swift
//  SafeBodaChallenge
//
//  Created by Rotem Nevgauker on 27/09/2019.
//  Copyright © 2019 Rotem Nevgauker. All rights reserved.
//

import Foundation
import UIKit
import ANLoader

extension Dictionary {
    var jsonStringRepresentation: String? {
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self,
                                                            options: [.prettyPrinted]) else {
                                                                return nil
        }
        
        return String(data: theJSONData, encoding: .ascii)
    }
}

extension NSMutableAttributedString{
    func setColorForText(_ textToFind: String, with color: UIColor) {
        let range = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        if range.location != NSNotFound {
            addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
    }
}

extension UIViewController {
    
    func showLoader() {
     //   ANLoader.showLoading("Loading", disableUI: true)

//        ANLoader.pulseAnimation = true //It will animate your Loading
//        ANLoader.activityColor = .red
//        ANLoader.activityBackgroundColor = .blue
//        ANLoader.activityTextColor = .clear
    }
    
    func hideLoader() {
      // ANLoader.hide()
    }
    
    
}
