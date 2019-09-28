//
//  MapViewController.swift
//  SafeBodaChallenge
//
//  Created by Rotem Nevgauker on 25/09/2019.
//  Copyright © 2019 Rotem Nevgauker. All rights reserved.
//

import UIKit
import MapKit
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline{
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blue
            polylineRenderer.lineWidth = 5.0
            return polylineRenderer
        }else{
            return MKOverlayRenderer()
        }
    }
    
}
class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var flights:[Flight]!
    var lines:[Line] = [Line]()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        hanlCoordinatesFetch()

        
    }
    
    func drawLine(line:Line){
        
        
        let point1 = CLLocationCoordinate2DMake(line.start.latitude, line.start.longitude)
        let point2 = CLLocationCoordinate2DMake(line.end.latitude, line.end.longitude)
        let points: [CLLocationCoordinate2D]
        points = [point1, point2]
        
        let geodesic = MKGeodesicPolyline(coordinates: points, count: 2)
        mapView.addOverlay(geodesic)
        UIView.animate(withDuration: 1.5, animations: { () -> Void in
            let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
            let region1 = MKCoordinateRegion(center: point1, span: span)
            self.mapView.setRegion(region1, animated: true)
        })
        
    }
    
    func hanlCoordinatesFetch() {

        for flight in flights {
            let airportCode1 = flight.departure.airportCode
            let airportCode2 = flight.arrival.airportCode

            LufthansaAPI.shared.fetchAirports(index: 0, airportCode: airportCode1, completion: {error1,airports1 in
                LufthansaAPI.shared.fetchAirports(index: 0, airportCode: airportCode2, completion: {error2,airports2 in
                    
                    
                    if error1 == nil && error2 == nil {
                       
                        
                        if let air1 = airports1?[0] {
                            let point1:Point = Point(lat: air1.latitude, long: air1.longitude)
                            if let air2 = airports2?[0] {
                                let point2:Point = Point(lat: air2.latitude, long: air2.longitude)
                                var line:Line = Line(s: point1, e: point2)
                                line.start = point1
                                line.end = point2
                                DispatchQueue.main.async {
                                    self.drawLine(line: line)
                                }
                                self.lines.append(line)
                                
                            }
                        }
                    }else {
                        //errors handling
                    }
                })
                
                

            })
        }
    }
    
    
}

