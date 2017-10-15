//
//  MapPin.swift
//  RocketWidget
//
//  Created by Suren Khorenyan on 15.10.17.
//  Copyright © 2017 Suren Khorenyan. All rights reserved.
//

import MapKit

class MapPin: NSObject, MKAnnotation {
    
    static let radius: CLLocationDistance = 1000
    static let rocketLocation = CLLocationCoordinate2DMake(55.783788, 37.5991618)
    static let defaultRegion = MKCoordinateRegionMakeWithDistance(rocketLocation, radius, radius)
    
    let title: String?
    var subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        super.init()
    }
}
