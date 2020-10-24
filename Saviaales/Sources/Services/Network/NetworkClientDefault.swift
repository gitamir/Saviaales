//
//  NetworkClientDefault.swift
//  Saviaales
//
//  Created by Amir Nuriev on 23.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import Foundation

class NetworkClientDefault: NetworkClient {
    private let urlSession: URLSession
    private let decoder: JSONDecoder

    init(urlSession: URLSession = .shared, decoder: JSONDecoder) {
        self.urlSession = urlSession
        self.decoder = decoder
    }

    @discardableResult
    func requestWithResource<T: Decodable>(
        _ resource: Requestable,
        _ completion: @escaping (Result<T, NetworkError>) -> Void
    ) -> CancellableTask {
        let task = urlSession.dataTask(with: resource.urlRequest) { [weak self] data, urlResponse, error in
            guard let self = self else {
                return
            }

            let requestCompletion = { (result: Result<T, NetworkError>) in
                DispatchQueue.main.async {
                    completion(result)
                }
            }

            if let error = error {
                return requestCompletion(.failure(.error(error)))
            }

            guard let response = urlResponse, let httpResponse = response as? HTTPURLResponse else {
                return requestCompletion(.failure(.noHttpResponse))
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                return requestCompletion(.failure(.networkError(code: httpResponse.statusCode, response: response)))
            }

            guard let data = data else {
                return requestCompletion(.failure(.noData))
            }

            do {
                let object = try self.decoder.decode(T.self, from: data)
                requestCompletion(.success(object))
            } catch {
                requestCompletion(.failure(.decodingError(error)))
            }
        }
        task.resume()
        return task
    }
}
