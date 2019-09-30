//
//  DestinationSelectionViewController.swift
//  SafeBodaChallenge
//
//  Created by Rotem Nevgauker on 25/09/2019.
//  Copyright © 2019 Rotem Nevgauker. All rights reserved.
//

import UIKit


class DestinationSelectionViewController: OriginSelectionViewController {

    
    var origin:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackButton()
        self.title = "Choose a city of destination"
        // Do any additional setup after loading the view.
    }
    override func didSelectAirport(airport:String){
        performSegue(withIdentifier: "resultsSegue", sender: self)
    }

}
