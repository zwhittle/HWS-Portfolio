//
//  AwardsTest.swift
//  PortfolioTests
//
//  Created by Zach Whittle on 8/26/23.
//

import CoreData
import XCTest
@testable import Portfolio

final class AwardsTest: BaseTestCase {
    let awards = Award.allAwards

    func testAwardIDMatchesName() {
        for award in awards {
            XCTAssertEqual(award.id, award.name, "Award ID should always match its name.")
        }
    }

    func testNewUserHasUnlockedNoAwards() {
        for award in awards {
            XCTAssertFalse(dataController.hasEarned(award: award), "New users should have earned no awards.")
        }
    }

    func testCreatingIssuesUnlocksAwards() {
        let values = [1, 10, 20, 50, 100, 250, 500, 1000]

        for (count, value) in values.enumerated() {
            var issues = [Issue]()

            for _ in 0..<value {
                let issue = Issue(context: manageObjectContext)
                issues.append(issue)
            }

            let matches = awards.filter { award in
                award.criterion == "issues" && dataController.hasEarned(award: award)
            }

            XCTAssertEqual(matches.count, count + 1, "Adding \(value) issues should unlock \(count + 1) awards.")
        }
    }

    func testClosingIssuesUnlocksAwards() {
        let values = [1, 10, 20, 50, 100, 250, 500, 1000]

        for (count, value) in values.enumerated() {
            var issues = [Issue]()

            for _ in 0..<value {
                let issue = Issue(context: manageObjectContext)
                issue.completed = true
                issues.append(issue)
            }

            let matches = awards.filter { award in
                award.criterion == "closed" && dataController.hasEarned(award: award)
            }

            XCTAssertEqual(matches.count, count + 1, "Completing \(value) issues should unlock \(count + 1) awards.")
        }
    }
}
