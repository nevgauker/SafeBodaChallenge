//
//  OriginSelectionViewController.swift
//  SafeBodaChallenge
//
//  Created by Rotem Nevgauker on 25/09/2019.
//  Copyright © 2019 Rotem Nevgauker. All rights reserved.
//

import UIKit
extension OriginSelectionViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell") as! CityTableViewCell
        let city = cities[indexPath.row]
        cell.setupGUI()
        cell.updateData(city: city)
        cell.contentView.alpha = 0.2
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
}


extension OriginSelectionViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.airportSelection(index: indexPath)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.6) {
             cell.contentView.alpha = 1.0
        }

       

        
        if indexPath.row >= cities.count - 1 {
            fetchCities()
        }
    
    }
    
}
class OriginSelectionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var index = 0
    
    var cities:[City] = [City]()
    
    var origin:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100.0
        fetchCities()
        self.title = "Choose an city of origin"
        
        
    }
    
    func fetchCities() {
        
        //showLoader()
        if LufthansaAPI.shared.needToFetchToken() {
            LufthansaAPI.shared.fetchToken(completion: {error,success in
                LufthansaAPI.shared.fetchCities(index: self.index, completion: { error,cities in
                   // self.hideLoader()

                    if error == nil {
                        if let theCities = cities {
                               self.cities.append(contentsOf: theCities)
                            self.index = self.cities.count
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                        }
                    }
                })
            })
        }else {
            LufthansaAPI.shared.fetchCities(index: self.index, completion: { error,cities in

               // self.hideLoader()
                
                if error == nil {
                    if let theCities = cities {
                        self.cities.append(contentsOf: theCities)
                        self.index = self.cities.count
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            
                        }
                    }
                }
            })
        }
    }
            
    func airportSelection(index:IndexPath) {
        
        let city = cities[index.row]
        
        let alertController = UIAlertController(title: "Airport", message: "Select an airport", preferredStyle: .actionSheet)
        
        
        for airport in city.airports {
            
            let code = airport
            let action = UIAlertAction(title: airport, style: .default, handler: { (action) -> Void in
                self.didSelectAirport(airport: code)
            })
            alertController.addAction(action)
            
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        alertController.addAction(cancelButton)
        self.navigationController!.present(alertController, animated: true, completion: nil)
        
    }
    
    func didSelectAirport(airport:String){
        self.origin = airport
        performSegue(withIdentifier: "destinationSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "destinationSegue" {
            
            let vc = segue.destination as! DestinationSelectionViewController
            vc.origin = self.origin
        }
    }

}
