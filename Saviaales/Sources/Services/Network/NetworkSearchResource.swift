//
//  NetworkSearchResource.swift
//  Saviaales
//
//  Created by Amir Nuriev on 23.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import Foundation

protocol Requestable {
    var urlRequest: URLRequest { get }
}

class NetworkSearchResource: Requestable {
    private let baseUrl: URL
    private let path: String?
    private let method: HttpMethod

    var urlRequest: URLRequest {
        guard let url = urlComponents.url else {
            fatalError("URL malformed!")
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }

    private lazy var urlComponents: URLComponents = {
        guard
            var urlComps = URLComponents(
                url: baseUrl.appendingPathComponent(path ?? ""),
                resolvingAgainstBaseURL: true
            )
        else {
            fatalError("URL malformed!")
        }

        return urlComps
    }()

    init(baseUrl: URL, path: String?, method: HttpMethod) {
        self.baseUrl = baseUrl
        self.path = path
        self.method = method
    }

    func updateWithParams(_ bodyParams: [String: String?]) {
        urlComponents.queryItems = bodyParams.map { URLQueryItem.init(name: $0, value: $1) }
    }
}
