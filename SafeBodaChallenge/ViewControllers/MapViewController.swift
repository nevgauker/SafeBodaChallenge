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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    
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
        addBackButton()
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

        
        let dispatchGroup = DispatchGroup()
        for flight in flights {
            let airportCode1 = flight.departure.airportCode
            let airportCode2 = flight.arrival.airportCode
            dispatchGroup.enter()

            LufthansaAPI.shared.fetchAirports(index: 0, airportCode: airportCode1, completion: {error1,airports1 in
                LufthansaAPI.shared.fetchAirports(index: 0, airportCode: airportCode2, completion: {error2,airports2 in
                    if error1 == nil && error2 == nil {
                        if let air1 = airports1?[0] {
                            let point1:Point = Point(lat: air1.latitude, long: air1.longitude, name: air1.airportCode)
                            if let air2 = airports2?[0] {
                                let point2:Point = Point(lat: air2.latitude, long: air2.longitude, name: air2.airportCode)
                                var line:Line = Line(s: point1, e: point2)
                                line.start = point1
                                line.end = point2
                                DispatchQueue.main.async {
                                    self.drawLine(line: line)
                                }
                                self.lines.append(line)
                                dispatchGroup.leave()
                                
                            }
                        }
                    }else {
                        //errors handling
                    }
                })
                
                

            })
        }
        dispatchGroup.notify(queue: .main) {
            print("All functions complete 👍")
            self.addAnnotations()
        }
    }
    
    func addAnnotations(){
   //     DispatchQueue.main.async {
        
        var arr:[MKAnnotation] = [MKAnnotation]()
        
            for (index,line) in self.lines.enumerated() {
                let london = MKPointAnnotation()
                london.title = line.start.name
                if index == 0 {
                    //add pin  to first point (departue)
                    london.coordinate = CLLocationCoordinate2D(latitude: line.start.latitude, longitude: line.start.longitude)

                }else {
                    //add pin  to second point (arival)
                      london.coordinate = CLLocationCoordinate2D(latitude: line.end
                        .latitude, longitude: line.end.longitude)
                    london.title = line.end.name

                }
                arr.append(london)
                
                if index == self.lines.count - 1 {
                    //last line
                    let london2 = MKPointAnnotation()
                    london2.title = line.start.name
                    london2.coordinate = CLLocationCoordinate2D(latitude: line.start.latitude, longitude: line.start.longitude)
                    arr.append(london2)
                }
            }
        self.mapView.addAnnotations(arr)

       // }
    }
            
            
  
    
    
}

