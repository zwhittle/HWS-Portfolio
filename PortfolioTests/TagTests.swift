//
//  TagTests.swift
//  PortfolioTests
//
//  Created by Zach Whittle on 8/26/23.
//

import CoreData
import XCTest
@testable import Portfolio

final class TagTests: BaseTestCase {
    func testCreatingTagsAndIssues() {
        let count = 10
        let expIssues = count * count

        for _ in 0..<count {
            let tag = Tag(context: manageObjectContext)

            for _ in 0..<count {
                let issue = Issue(context: manageObjectContext)
                tag.addToIssues(issue)
            }
        }

        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), count, "\(count) tags expected.")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), expIssues, "\(expIssues) issues expected.")
    }

    func testDeletingTagDoesNotDeleteIssues() throws {
        dataController.createSampleData()

        let request = NSFetchRequest<Tag>(entityName: "Tag")
        let tags = try manageObjectContext.fetch(request)

        dataController.delete(tags[0])

        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), 4, "Expected 4 tags.")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), 50, "Expected 50 issues.")
    }
}
