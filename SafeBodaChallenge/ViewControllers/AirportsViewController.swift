//
//  AirportsViewController.swift
//  SafeBodaChallenge
//
//  Created by Rotem Nevgauker on 27/09/2019.
//  Copyright © 2019 Rotem Nevgauker. All rights reserved.
//

import UIKit

extension AirportsViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AirportTableViewCell") as! AirportTableViewCell
        let airport = AppData.shared.getAirports()[indexPath.row]
        
        cell.updateData(airport: airport)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.shared.getAirports().count
    }
    
}
class AirportsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0


        // Do any additional setup after loading the view.
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
