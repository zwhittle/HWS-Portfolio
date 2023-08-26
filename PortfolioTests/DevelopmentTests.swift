//
//  DevelopmentTests.swift
//  PortfolioTests
//
//  Created by Zach Whittle on 8/26/23.
//

import CoreData
import XCTest
@testable import Portfolio

final class DevelopmentTests: BaseTestCase {
    func testSampleDataCreationWorks() {
        dataController.createSampleData()

        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), 5, "Expected tags: 5")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), 50, "Expected issue: 50")
    }

    func testDeleteAllClearsEverything() {
        dataController.createSampleData()
        dataController.deleteAll()

        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), 0, "Expected tags: 0")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), 0, "Expected issue: 0")
    }

    func testExampleTagHasNoIssues() {
        let tag = Tag.example
        XCTAssertEqual(tag.issues?.count, 0, "Expected issues: 0")
    }

    func testExampleIssueIsHighPriority() {
        let issue = Issue.example
        XCTAssertEqual(issue.priority, 2, "Expected priority: 2 - High")
    }
}
