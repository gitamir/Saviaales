//
//  ContainerFactory.swift
//  Saviaales
//
//  Created by Amir Nuriev on 23.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import Foundation

enum ContainerKind {
    case escapeSpbDefault
}

struct ContainerFactory {
    private let baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    func makeContainer(_ containerKind: ContainerKind) -> DependencyContainer {
        guard let baseUrl = URL(string: baseUrl) else {
            fatalError("URL malformed!")
        }

        switch containerKind {
            case .escapeSpbDefault:
                let container = Container()
                let networkClient = NetworkClientDefault(decoder: makeDecoder())
                container.register { (object: inout AirportsServiceDependency) in
                    let airportsResource = NetworkSearchResource(baseUrl: baseUrl, path: "places", method: .get)
                    object.airportsService = AirportsServiceDefault(
                        networkClient: networkClient,
                        resource: airportsResource
                    )
                }
                return container
        }
    }

    private func makeDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
