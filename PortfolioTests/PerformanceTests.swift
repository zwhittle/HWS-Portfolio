//
//  PerformanceTests.swift
//  PortfolioTests
//
//  Created by Zach Whittle on 8/26/23.
//

import XCTest
@testable import Portfolio

final class PerformanceTests: BaseTestCase {
    func testAwardCalculationPerformance() {
        for _ in 1...100 {
            dataController.createSampleData()
        }

        let awards = Array(repeating: Award.allAwards, count: 25).joined()
        XCTAssertEqual(awards.count, 500, "This checks the awards count is constant. Changis this if you add awards.")

        measure {
            _ = awards.filter(dataController.hasEarned)
        }
    }
}
