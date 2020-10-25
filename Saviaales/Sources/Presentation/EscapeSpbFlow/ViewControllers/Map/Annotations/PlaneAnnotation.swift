//
//  PlaneAnnotation.swift
//  Saviaales
//
//  Created by Amir Nuriev on 25.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import MapKit

class PlaneAnnotation: NSObject, MKAnnotation {
    @objc dynamic var coordinate: CLLocationCoordinate2D
    let planeImage: UIImage

    init(planeImage: UIImage, coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)) {
        self.coordinate = coordinate
        self.planeImage = planeImage
    }
}
