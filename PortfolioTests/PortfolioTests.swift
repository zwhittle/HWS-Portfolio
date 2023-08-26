//
//  PortfolioTests.swift
//  PortfolioTests
//
//  Created by Zach Whittle on 8/26/23.
//

import CoreData
import XCTest
@testable import Portfolio

class BaseTestCase: XCTestCase {
    var dataController: DataController!
    var manageObjectContext: NSManagedObjectContext!

    override func setUpWithError() throws {
        dataController = DataController(inMemory: true)
        manageObjectContext = dataController.container.viewContext
    }
}
