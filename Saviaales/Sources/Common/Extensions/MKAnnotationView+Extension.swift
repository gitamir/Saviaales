//
//  MKAnnotationView+Extension.swift
//  Saviaales
//
//  Created by Amir Nuriev on 25.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import MapKit

extension MKAnnotationView {
    class var reuseIdentifier: String {
        String(describing: self)
    }

    private class func dequeueView<T: MKAnnotationView>(from mapView: MKMapView) -> T {
        guard let view = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? T else {
            fatalError("Error dequeuing view")
        }
        return view
    }

    class func dequeue(from mapView: MKMapView) -> Self {
        dequeueView(from: mapView)
    }
}
