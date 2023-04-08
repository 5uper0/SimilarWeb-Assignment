// URLSessionDataTaskProtocol.swift
// SimilarWeb-AssignmentTests
//
// Created by Oleh Veheria on 08.04.2023.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }
