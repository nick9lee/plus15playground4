//
//  LocationManager.swift
//  plus15playground4
//
//  Created by Nicholas Lee on 2022-03-28.
//

import Foundation
import CoreLocation
import UIKit

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var userHeading: CLLocationDirection?
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        // Set up your manager properties here
        manager.delegate = self
        return manager
    }()
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
         if newHeading.headingAccuracy < 0 { return }

         let heading = newHeading.trueHeading > 0 ? newHeading.trueHeading : newHeading.magneticHeading
         userHeading = heading
         NotificationCenter.default.post(name: Notification.Name(rawValue: "myKey"), object: self, userInfo: nil)
    }
}
