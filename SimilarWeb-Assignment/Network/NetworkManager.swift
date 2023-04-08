//
//  NetworkManager.swift
//  SimilarWeb-Assignment
//
//  Created by Oleh Veheria on 08.04.2023.
//

import Foundation

// The APIError enum represents the different types of errors that can occur while making network requests or decoding the response.
enum APIError: Error {
    case invalidURL
    case requestFailed(Error)
    case decodingFailed(Error)
}

// The NetworkProtocol protocol defines the interface for making API requests.
protocol NetworkProtocol {
    func searchPhotos(query: String, completion: @escaping (Result<[Photo], APIError>) -> Void)
}

// The NetworkManager class handles making API requests, and conforms to the NetworkProtocol protocol.
final class NetworkManager {
    private let clientID = "c99a7e7599297260b46b7c9cf36727badeb1d37b1f24aa9ef5d844e3fbed76fe"
    private let endpoint = "https://api.unsplash.com/search/"
    private let session: URLSessionProtocol

    // The session property represents the URLSession used to make requests, and defaults to the shared URLSession.
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
}

extension NetworkManager: NetworkProtocol {

    // The searchPhotos method uses the request method to make a GET request to the Unsplash API's search photos
    // endpoint, and returns the search results as an array of Photo objects.
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
