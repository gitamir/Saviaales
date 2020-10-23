//
//  Airport.swift
//  Saviaales
//
//  Created by Amir Nuriev on 23.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import CoreLocation

struct Airport: Decodable, Equatable {
    struct Location: Decodable {
        private let latitude: Double
        let longitude: Double
        var coordinate: CLLocation {
            CLLocation(latitude: latitude, longitude: longitude)
        }

        enum CodingKeys: String, CodingKey {
            case latitude = "lat"
            case longitude = "lon"
        }
    }

    let airportName: String?
    let location: Location
    let name: String?
    let iata: String

    static func == (lhs: Airport, rhs: Airport) -> Bool {
        lhs.iata == rhs.iata
    }
}
