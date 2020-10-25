//
//  AirportsService.swift
//  Saviaales
//
//  Created by Amir Nuriev on 23.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

protocol AirportsService {
    var departureAirport: Airport { get }
    var destinationAirport: Airport? { get set }
    var isFlightPossible: Bool { get }
    func getAirports(for queryString: String, _ completion: @escaping (Result<[Airport], NetworkError>) -> Void)
}

protocol AirportsServiceDependency {
    var airportsService: AirportsService! { get set }
}
