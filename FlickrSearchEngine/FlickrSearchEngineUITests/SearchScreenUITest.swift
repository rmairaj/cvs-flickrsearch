//
//  SearchScreenUITest.swift
//  FlickrSearchEngineUITests
//
//  Created by Mairaj, Rija - The Intersect Group on 2/21/24.
//

import XCTest

final class SearchScreenUITest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchBar() throws {
        let app = XCUIApplication()
        app.launch()
        
        let expectedValue = "Porcupine"
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.exists, "Search Field doesn't exist")
        
        searchField.tap()
        searchField.typeText("Porcupine")
        let actualValue = searchField.value as? String
        XCTAssertEqual(actualValue, expectedValue)
    }

    func testLaunchPerformance() throws {
        
    }
}
