//
//  NetworkManagerTests.swift
//  SimilarWeb-AssignmentTests
//
//  Created by Oleh Veheria on 08.04.2023.
//

import XCTest
@testable import SimilarWeb_Assignment

final class NetworkManagerTests: XCTestCase {
    func testSuccessfulRequest() {
        let mockSession = MockURLSession()
        let data = "{\"results\": [{\"id\": \"123\", \"description\": \"Test description\", \"urls\": {\"small\": \"https://example.com/image.jpg\"}}]}".data(using: .utf8)
        let response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        mockSession.data = data
        mockSession.response = response

        let networkManager = NetworkManager(session: mockSession)
        let expectation = XCTestExpectation(description: "Fetch photos")

        networkManager.searchPhotos(query: "sea") { result in
            switch result {
            case .success(let photos):
                XCTAssertEqual(photos.count, 1)
                XCTAssertEqual(photos[0].id, "123")
                XCTAssertEqual(photos[0].description, "Test description")
            case .failure:
                XCTFail("Expected success but received an error")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
