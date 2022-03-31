//
//  ViewController.swift
//  plus15playground4
//
//  Created by Nicholas Lee on 2022-01-18.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    // documentation
    // https://stackoverflow.com/questions/39762732/ios-10-heading-arrow-for-mkuserlocation-dot

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    lazy var locationManager: CLLocationManager = {
            let manager = CLLocationManager()
            manager.delegate = self
            return manager
        }()

    var userLocationAnnotation: UserLocationAnnotation!
    
    override func viewDidLoad() {
            super.viewDidLoad()

            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation

            locationManager.startUpdatingHeading()
            locationManager.startUpdatingLocation()

            userLocationAnnotation = UserLocationAnnotation(withCoordinate: CLLocationCoordinate2D(), heading: 0.0)

            mapView.addAnnotation(userLocationAnnotation)
        mapView.showsUserLocation = true
        }

    @IBAction func buttonpressed(_ sender: Any) {
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
            userLocationAnnotation.heading = newHeading.trueHeading
        }

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            userLocationAnnotation.coordinate = locations.last!.coordinate
        }

        public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if let annotation = annotation as? UserLocationAnnotation {
                let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "UserLocationAnnotationView") ?? UserLocationAnnotationView(annotation: annotation, reuseIdentifier: "UserLocationAnnotationView")
                return annotationView
            } else {
                return MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            }
        }
}

