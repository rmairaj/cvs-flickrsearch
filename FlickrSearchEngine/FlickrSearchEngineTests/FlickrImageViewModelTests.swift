//
//  FlickrImageViewModelTests.swift
//  FlickrSearchEngineTests
//
//  Created by Mairaj, Rija - The Intersect Group on 2/21/24.
//

import XCTest
@testable import FlickrSearchEngine

final class FlickrImageViewModelTests: XCTestCase {
    var flickrImageObject: FlickrImage!

    override func setUpWithError() throws {
        flickrImageObject = FlickrImage(title: "Nisthilfe 17468",
                                        link: "https://www.flickr.com//photos//12639178@N07//53544213440//",
                                        description: "<p><a href='https://www.flickr.com/people/12639178@N07/'>naturgucker.de</a> posted a photo:</p> <p><a href=\'https://www.flickr.com/photos/12639178@N07/53544213440/' title='Nisthilfe 17468\'><img src=\"https://live.staticflickr.com/65535/53544213440_767af316a9_m.jpg\" width=\"180\" height=\"240\" alt=\"Nisthilfe 17468\" /></a></p> <p>(c) Ingrid Janke</p> ",
                                        author: "nobody@flickr.com (\"naturgucker.de\")",
                                        media: ["m":"https://live.staticflickr.com/65535/53544213440_767af316a9_m.jpg"],
                                        published: "2024-02-21T20:30:55Z")
    }

    override func tearDownWithError() throws {
        flickrImageObject = nil
    }

    func testInitialization() throws {
        let flickrImageViewModel = FlickrImageViewModel(flickrImageData: flickrImageObject)
        XCTAssertNotNil(flickrImageViewModel, "View model should not be nil.")
    }

    func testImageDescription() throws {
        let flickrImageViewModel = FlickrImageViewModel(flickrImageData: flickrImageObject)
        let description = flickrImageViewModel.description
        XCTAssertTrue(description == "(c) Ingrid Janke", "The description should be equal to '(c) Ingrid Janke'")
    }
    
    func testPublishingDateDormat() throws {
        let flickrImageViewModel = FlickrImageViewModel(flickrImageData: flickrImageObject)
        let formattedPublishDate = flickrImageViewModel.publishDate
        XCTAssertTrue(formattedPublishDate == "Feb 21, 2024", "The published date should be Feb 21, 2024")
    }
    
    func testImageURL() throws {
        let flickrImageViewModel = FlickrImageViewModel(flickrImageData: flickrImageObject)
        let imageURL = flickrImageViewModel.imageURL
        XCTAssertNotNil(imageURL, "Flickr image url should not be nil")
    }

}
