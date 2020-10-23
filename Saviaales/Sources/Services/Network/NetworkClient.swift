//
//  NetworkClient.swift
//  Saviaales
//
//  Created by Amir Nuriev on 23.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case noHttpResponse
    case noData
    case error(Error)
    case networkError(code: Int, response: URLResponse)
    case decodingError(Error)
}

protocol NetworkClient {
    @discardableResult
    func requestWithResource<T: Decodable>(
        _ resource: Requestable,
        _ completion: @escaping (Result<T, NetworkError>) -> Void
    ) -> CancellableTask
}

protocol CancellableTask {
    func cancel()
}
