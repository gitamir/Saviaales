//
//  CGPoint+Extensions.swift
//  Saviaales
//
//  Created by Amir Nuriev on 25.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import MapKit

extension CGPoint {
    var mkMapPoint: MKMapPoint {
        MKMapPoint(x: Double(x), y: Double(y))
    }
}
