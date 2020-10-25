//
//  AirportsServiceDefault.swift
//  Saviaales
//
//  Created by Amir Nuriev on 23.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import Foundation

class AirportsServiceDefault: AirportsService {
    private enum Constants {
        static let defaultLocaleCode = "ru"
    }

    var departureAirport: Airport = .defaultDeparture
    var destinationAirport: Airport?
    var isFlightPossible: Bool {
        destinationAirport != nil && departureAirport != destinationAirport
    }

    private let networkClient: NetworkClient
    private let resource: NetworkSearchResource
    private var currentTask: CancellableTask?

    init(networkClient: NetworkClient, resource: NetworkSearchResource) {
        self.networkClient = networkClient
        self.resource = resource
        getAirports(for: Airport.defaultDepartureRequestString) { [weak self] result in
            guard let self = self else { return }

            if case .success(let data) = result {
                data.first.map { self.departureAirport = $0 }
            }
        }
    }

    func getAirports(for queryString: String, _ completion: @escaping (Result<[Airport], NetworkError>) -> Void) {
        currentTask?.cancel()
        let localeCode = Locale.current.languageCode ?? Constants.defaultLocaleCode
        resource.updateWithParams(["term": queryString, "locale": localeCode])
        currentTask = networkClient.requestWithResource(resource, completion)
    }
}
