//
//  SimilarWeb_AssignmentUITests.swift
//  SimilarWeb-AssignmentUITests
//
//  Created by Oleh Veheria on 08.04.2023.
//

import XCTest

final class SimilarWeb_AssignmentUITests: XCTestCase {

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
