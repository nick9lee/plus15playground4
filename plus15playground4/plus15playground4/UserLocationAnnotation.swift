//
//  UserLocationAnnotation.swift
//  plus15playground4
//
//  Created by Nicholas Lee on 2022-03-28.
//

import Foundation
import UIKit
import MapKit

class UserLocationAnnotation: MKPointAnnotation {
    public init(withCoordinate coordinate: CLLocationCoordinate2D, heading: CLLocationDirection) {
        self.heading = heading

        super.init()
        self.coordinate = coordinate
    }

    dynamic public var heading: CLLocationDirection
}
