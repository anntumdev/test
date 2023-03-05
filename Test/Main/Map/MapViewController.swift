//
//  MapViewController.swift
//  Test
//
//  Created by Anna on 05.03.2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var city: City? = nil
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        if let city = city {
            setAnnotation(city: city)
        }
    }
    private func setAnnotation(city: City) {
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: Double(city.coord.lat), longitude: Double(city.coord.lon))
        let region = MKCoordinateRegion(center: centerCoordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        annotation.coordinate = centerCoordinate
        annotation.title = "\(city.name), \(city.country)"
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
        
    }
}
