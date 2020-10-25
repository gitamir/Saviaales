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
        private let longitude: Double
        var coordinate: CLLocation {
            CLLocation(latitude: latitude, longitude: longitude)
        }

        enum CodingKeys: String, CodingKey {
            case latitude = "lat"
            case longitude = "lon"
        }

        init(latitude: Double, longitude: Double) {
            self.latitude = latitude
            self.longitude = longitude
        }
    }

    let airportName: String?
    let location: Location
    let name: String?
    let iata: String

    static func == (lhs: Airport, rhs: Airport) -> Bool {
        lhs.iata == rhs.iata
    }

    static let defaultDeparture = Airport(
        airportName: "Pulkovo Airport",
        location: .init(latitude: 59.806084, longitude: 30.3083),
        name: "Saint Petersburg, Russia",
        iata: "LED"
    )
    static let defaultDepartureRequestString = "saint petersburg"
}
