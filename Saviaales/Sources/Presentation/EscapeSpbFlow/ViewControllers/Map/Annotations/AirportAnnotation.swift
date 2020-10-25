//
//  AirportAnnotation.swift
//  Saviaales
//
//  Created by Amir Nuriev on 25.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import MapKit

class AirportAnnotation: NSObject, MKAnnotation {
    @objc dynamic var coordinate: CLLocationCoordinate2D
    let airport: Airport

    init(airport: Airport) {
        coordinate = airport.location.coordinate.coordinate
        self.airport = airport
        super.init()
    }
}
