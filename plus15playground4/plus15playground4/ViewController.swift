//
//  ViewController.swift
//  plus15playground4
//
//  Created by Nicholas Lee on 2022-01-18.
//

import UIKit
import MapKit

class ViewController: UIViewController{
    
    // documentation
    // https://stackoverflow.com/questions/39762732/ios-10-heading-arrow-for-mkuserlocation-dot

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    var headingImageView: UIImageView?
    var locationManager: LocationManager = LocationManager()
    
    let locationManager2 = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        locationManager2.requestWhenInUseAuthorization()
        locationManager2.desiredAccuracy = kCLLocationAccuracyBest
        locationManager2.distanceFilter = kCLDistanceFilterNone
        locationManager2.startUpdatingLocation()
        mapView.showsUserLocation = true
        //mapView.showsCompass = true
        locationManager.locationManager.startUpdatingHeading()
    }

    @IBAction func buttonpressed(_ sender: Any) {
        //center on user location
        let userLocation = locationManager2.location

        if userLocation != nil {
            let region = MKCoordinateRegion(center: userLocation!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
                    
            mapView.setRegion(region, animated: true)
        }
    }
    
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        if views.last?.annotation is MKUserLocation {
            addHeadingView(toAnnotationView: views.last!)
        }
    }
    
    func addHeadingView(toAnnotationView annotationView: MKAnnotationView) {
        if headingImageView == nil {
            let image = UIImage(named: "directionalArrow")
            headingImageView = UIImageView(image: image)
            headingImageView!.frame = CGRect(x: (annotationView.frame.size.width - image!.size.width)/2, y: (annotationView.frame.size.height - image!.size.height)/2, width: image!.size.width, height: image!.size.height)
            annotationView.insertSubview(headingImageView!, at: 0)
            headingImageView!.isHidden = true
         }
    }
    
    func updateHeadingRotation() {
        if let heading = locationManager.userHeading,
                let headingImageView = headingImageView {

                headingImageView.isHidden = false
                let rotation = CGFloat(heading/180 * Double.pi)
                headingImageView.transform = CGAffineTransform(rotationAngle: rotation)
            }
        }
}

