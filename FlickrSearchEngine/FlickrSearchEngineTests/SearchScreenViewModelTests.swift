//
//  SearchScreenViewModelTests.swift
//  FlickrSearchEngineTests
//
//  Created by Mairaj, Rija - The Intersect Group on 2/20/24.
//

import XCTest
@testable import FlickrSearchEngine

final class SearchScreenViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTrimmingSearchText() throws {
        let viewModel = SearchScreenViewModel()
        let searchText = "Porcupine@"
        let trimmedText = viewModel.trimSearchText(searchText)
        XCTAssertEqual(trimmedText, "Porcupine", "Text formatted to: \(trimmedText)")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
