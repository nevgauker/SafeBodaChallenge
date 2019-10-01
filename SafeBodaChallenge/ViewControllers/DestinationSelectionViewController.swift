//
//  DestinationSelectionViewController.swift
//  SafeBodaChallenge
//
//  Created by Rotem Nevgauker on 25/09/2019.
//  Copyright © 2019 Rotem Nevgauker. All rights reserved.
//

import UIKit


class DestinationSelectionViewController: OriginSelectionViewController {

    var destination:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackButton()
        self.title = "Choose a city of destination"
        // Do any additional setup after loading the view.
    }
    override func didSelectAirport(airport:String){
        destination = airport
        performSegue(withIdentifier: "resultsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultsSegue" {
            let vc = segue.destination  as! ResultsViewController
            vc.destination = destination
            vc.origin = self.origin
        }
    }

}
