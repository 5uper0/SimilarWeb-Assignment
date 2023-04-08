//
//  MockURLSessionDataTask.swift
//  SimilarWeb-AssignmentTests
//
//  Created by Oleh Veheria on 08.04.2023.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    func resume() {
        closure()
    }
}
