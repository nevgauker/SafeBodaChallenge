//
//  OriginSelectionViewController.swift
//  SafeBodaChallenge
//
//  Created by Rotem Nevgauker on 25/09/2019.
//  Copyright © 2019 Rotem Nevgauker. All rights reserved.
//

import UIKit

class OriginSelectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        LufthansaAPI.shared.fetchAirports(completion: {error,data in
        
        
        })

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didPressSelect(_ sender: Any) {
         performSegue(withIdentifier: "destinationSegue", sender: self)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
