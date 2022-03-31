//
//  ViewController.swift
//  plus15playground4
//
//  Created by Nicholas Lee on 2022-01-18.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var displayBuisnessesToggleButton: UIButton!
    
    var displayBuisnesses = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self;
        
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.045000, longitude: -114.069000), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
    }

    @IBAction func displayBuisnessesToggleButtonPressed(_ sender: Any) {
        if displayBuisnesses {
            
        } else {
            
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    
}

struct PointOfInterest: Codable {
    let key: String
    let title: String
    var type: String = "poi"
    let lat: Double
    let lon: Double
}

class Pin: MKPointAnnotation {
    var type: String
    var key: String
    
    override init() {
        type = ""
        key = ""
        super.init()
    }
}

