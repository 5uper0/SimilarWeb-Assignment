//
//  NetworkManager.swift
//  SimilarWeb-Assignment
//
//  Created by Oleh Veheria on 08.04.2023.
//

import Foundation

/*
 This is Networking layer. I've provided it with a protocol for make it available for testing.

*/


enum APIError: Error {
    case invalidURL
    case requestFailed(Error)
    case decodingFailed(Error)
}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

protocol NetworkProtocol {
    func searchPhotos(query: String, completion: @escaping (Result<[Photo], APIError>) -> Void)
}

class NetworkManager: NetworkProtocol {
    private let clientID = "c99a7e7599297260b46b7c9cf36727badeb1d37b1f24aa9ef5d844e3fbed76fe"
    private let endpoint = "https://api.unsplash.com/search/"
    private let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func searchPhotos(query: String, completion: @escaping (Result<[Photo], APIError>) -> Void) {
        let endpoint = "https://api.unsplash.com/search/photos"
        let parameters = ["query": query, "page": "1"]

        request(endpoint: endpoint, parameters: parameters) { (result: Result<PhotoResponse, APIError>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

private extension NetworkManager {

    func request<T: Decodable>(endpoint: String, parameters: [String: String] = [:], completion: @escaping (Result<T, APIError>) -> Void) {
        var components = URLComponents(string: endpoint)
        var queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        queryItems.append(URLQueryItem(name: "client_id", value: clientID))
        components?.queryItems = queryItems

        guard let url = components?.url else {
            completion(.failure(.invalidURL))
            return
        }

        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }

            guard let data = data else {
                completion(.failure(.requestFailed(NSError(domain: "", code: -1, userInfo: nil))))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingFailed(error)))
            }
        }

        task.resume()
    }
}
