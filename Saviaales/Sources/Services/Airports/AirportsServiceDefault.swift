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

    private let networkClient: NetworkClient
    private let resource: NetworkSearchResource
    private var currentTask: CancellableTask?

    init(networkClient: NetworkClient, resource: NetworkSearchResource) {
        self.networkClient = networkClient
        self.resource = resource
    }

    func getAirports(for queryString: String, _ completion: @escaping (Result<[Airport], NetworkError>) -> Void) {
        currentTask?.cancel()
        let localeCode = Locale.current.languageCode ?? Constants.defaultLocaleCode
        resource.updateWithParams(["term": queryString, "locale": localeCode])
        currentTask = networkClient.requestWithResource(resource, completion)
    }
}
