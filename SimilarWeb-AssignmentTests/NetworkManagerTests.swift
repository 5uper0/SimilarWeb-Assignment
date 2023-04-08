//
//  NetworkManagerTests.swift
//  SimilarWeb-AssignmentTests
//
//  Created by Oleh Veheria on 08.04.2023.
//

@testable import SimilarWeb_Assignment
import XCTest

final class NetworkManagerTests: XCTestCase {

    // Mock session and manager to use in tests
    var sut: NetworkManager!
    var mockSession: MockURLSession!

    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        sut = NetworkManager(session: mockSession)
    }

    override func tearDown() {
        sut = nil
        mockSession = nil
        super.tearDown()
    }

    // Test successful request
    func testSearchPhotosSuccess() {
        // Given
        let query = "nature"
        let photoResponse = PhotoResponse(results: [MockData.photo])
        mockSession.data = try? JSONEncoder().encode(photoResponse)
        mockSession.response = HTTPURLResponse(url: URL(string: "https://api.unsplash.com/search/photos")!,
                                               statusCode: 200, httpVersion: nil, headerFields: nil)
        var expectedPhotos: [Photo]?

        // When
        sut.searchPhotos(query: query) { result in
            switch result {
            case .success(let photos):
                expectedPhotos = photos
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
        }

        // Then
        XCTAssertEqual(expectedPhotos, [MockData.photo])
    }

    // Test request failure
    func testSearchPhotosFailure() {
        // Given
        let query = "nature"
        mockSession.response = HTTPURLResponse(url: URL(string: "https://api.unsplash.com/search/photos")!,
                                               statusCode: 500, httpVersion: nil, headerFields: nil)
        var expectedError: APIError?

        // When
        sut.searchPhotos(query: query) { result in
            switch result {
            case .success:
                XCTFail("Expected failure")
            case .failure(let error):
                expectedError = error
            }
        }

        // Then
        XCTAssertNotNil(expectedError)
    }
}
