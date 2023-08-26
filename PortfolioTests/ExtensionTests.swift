//
//  ExtensionTests.swift
//  PortfolioTests
//
//  Created by Zach Whittle on 8/26/23.
//

import CoreData
import XCTest
@testable import Portfolio

final class ExtensionTests: BaseTestCase {
    func testIssueTitleUnwrap() {
        let issue = Issue(context: manageObjectContext)
        issue.title = "Example issue"

        XCTAssertEqual(issue.issueTitle, "Example issue", "Changing title should also change issueTitle.")

        issue.issueTitle = "Updated issue"
        XCTAssertEqual(issue.title, "Updated issue", "Changing issueTitle should also change title.")
    }

    func testIssueContentUnwrap() {
        let issue = Issue(context: manageObjectContext)
        issue.content = "Example issue"

        XCTAssertEqual(issue.issueContent, "Example issue", "Changing content should also change issueContent.")

        issue.issueContent = "Updated issue"
        XCTAssertEqual(issue.content, "Updated issue", "Changing issueContent should also change content.")
    }

    func testIssueCreationDateUnwrap() {
        let testDate = Date.now
        let issue = Issue(context: manageObjectContext)

        issue.creationDate = testDate
        XCTAssertEqual(issue.issueCreationDate, testDate, "Changing creationDate should also change issueCreationDate.")
    }

    func testIssueTagsUnwrap() {
        let tag = Tag(context: manageObjectContext)
        let issue = Issue(context: manageObjectContext)

        XCTAssertEqual(issue.issueTags.count, 0, "A new issue should have no tags.")

        issue.addToTags(tag)
        XCTAssertEqual(issue.issueTags.count, 1, "Expected tags: 1")
    }

    func testIssueTagList() {
        let tag = Tag(context: manageObjectContext)
        let issue = Issue(context: manageObjectContext)

        tag.name = "My Tag"
        issue.addToTags(tag)

        XCTAssertEqual(issue.issueTagsList, "My Tag", "Expected tagsList to match 'My Tag'.")
    }

    func testIssueSortingIsStable() {
        let issue1 = Issue(context: manageObjectContext)
        issue1.title = "B issue"
        issue1.creationDate = Date.now

        let issue2 = Issue(context: manageObjectContext)
        issue2.title = "B issue"
        issue2.creationDate = Date.now.addingTimeInterval(1)

        let issue3 = Issue(context: manageObjectContext)
        issue3.title = "A issue"
        issue3.creationDate = Date.now.addingTimeInterval(100)

        let allIssues = [issue1, issue2, issue3]
        let sorted = allIssues.sorted()

        XCTAssertEqual([issue3, issue1, issue2], sorted, "Sorting issue arraps should use name then creationDate.")
    }

    func testTagIDUnwrap() {
        let tag = Tag(context: manageObjectContext)

        tag.id = UUID()
        XCTAssertEqual(tag.tagID, tag.id, "Changing id should also change tagID.")
    }

    func testTagToNameUnwrap() {
        let tag = Tag(context: manageObjectContext)

        tag.name = "Example Tag"
        XCTAssertEqual(tag.tagName, "Example Tag", "Changing name should also change tagName.")
    }

    func testTagActiveIssues() {
        let tag = Tag(context: manageObjectContext)
        let issue =  Issue(context: manageObjectContext)

        XCTAssertEqual(tag.tagActiveIssues.count, 0, "Expected active issues: 0.")

        tag.addToIssues(issue)
        XCTAssertEqual(tag.tagActiveIssues.count, 1, "Expected active issues: 1.")

        issue.completed = true
        XCTAssertEqual(tag.tagActiveIssues.count, 0, "Expected active issues: 0.")
    }

    func testTagSortingIsStable() {
        let tag1 = Tag(context: manageObjectContext)
        tag1.name = "B tag"
        tag1.id = UUID()

        let tag2 = Tag(context: manageObjectContext)
        tag2.name = "B tag"
        tag2.id = UUID(uuidString: "FFFFFFFF-5E27-430B-8730-19BA16E3FBE2")

        let tag3 = Tag(context: manageObjectContext)
        tag3.name = "A tag"
        tag3.id = UUID()

        let allTags = [tag1, tag2, tag3]
        let sortedTags = allTags.sorted()

        XCTAssertEqual([tag3, tag1, tag2], sortedTags, "Sorting tag array should use name then id.")
    }

    func testBundleDecodingAwards() {
        let awards = Bundle.main.decode("Awards.json", as: [Award].self)
        XCTAssertFalse(awards.isEmpty, "Awards.json should decode to a non-empty array.")
    }

    func testDecodingString() {
        let bundle = Bundle(for: ExtensionTests.self)
        let data = bundle.decode("DecodableString.json", as: String.self)
        XCTAssertEqual(data, "Never ask a starfish for directions.", "The string must match DecodableString.json.")
    }

    func testDecodingDictionary() {
        let bundle = Bundle(for: ExtensionTests.self)
        let data = bundle.decode("DecodableDictionary.json", as: [String: Int].self)

        XCTAssertEqual(data.count, 3, "Expected 3 items from DecodableDictionary.json")
        XCTAssertEqual(data["One"], 1, "The dictionary should contain the value 1 for the key 'One'")
    }
}
