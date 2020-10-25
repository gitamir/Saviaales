//
//  MKMapPoint+Extensions.swift
//  Saviaales
//
//  Created by Amir Nuriev on 25.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import MapKit

extension MKMapPoint {
    var cgPoint: CGPoint {
        CGPoint(x: x, y: y)
    }
}
