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
    
    func addBackButton() {
        let backBtn = UIBarButtonItem()
        let image: UIImage = UIImage(named: "Back")!
        backBtn.image = image
        backBtn.action = #selector(popSelf)
        backBtn.target = self
        navigationItem.leftBarButtonItem = backBtn
    }
    @objc private func popSelf() {
        navigationController?.popViewController(animated: true)
        // do your stuff if you needed
    }
    
    func showLoader() {
        DispatchQueue.main.async {
            ANLoader.showLoading("Loading", disableUI: true)
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            ANLoader.hide()
        }
    }
    
}
