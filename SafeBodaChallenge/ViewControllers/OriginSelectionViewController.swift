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
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
}


extension OriginSelectionViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.airportSelection(index: indexPath)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        if indexPath.row >= cities.count - 1 {
            fetchCities()
        }
    
    }
}
class OriginSelectionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var index = 0
    
    var cities:[City] = [City]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100.0
        fetchCities()
        self.title = "Choose an city of origin"
        
        
    }
    
    func fetchCities() {
        if LufthansaAPI.shared.needToFetchToken() {
            LufthansaAPI.shared.fetchToken(completion: {error,success in
                LufthansaAPI.shared.fetchCities(index: self.index, completion: { error,cities in
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
            
            
        
                
                
          

                
            
            
            
//
//            LufthansaAPI.shared.fetchCities(index: 0, completion: { error,cities in
//                if error == nil {
//                    if let theCities = cities {
//                        self.cities.append(contentsOf: theCities)
//                        DispatchQueue.main.async {
//                            self.tableView.reloadData()
//
//                        }
//                    }
//                }
//
//
//            })
  //      }
        
       
    
    func airportSelection(index:IndexPath) {
        
        let city = cities[index.row]
        
        let alertController = UIAlertController(title: "Airport", message: "Select an air port", preferredStyle: .actionSheet)
        
        
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
        performSegue(withIdentifier: "destinationSegue", sender: self)
    }

}
