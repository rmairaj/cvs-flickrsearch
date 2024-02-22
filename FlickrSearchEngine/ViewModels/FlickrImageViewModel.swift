//
//  FlickrImageViewModel.swift
//  FlickrSearchEngine
//
//  Created by Mairaj, Rija - The Intersect Group on 2/20/24.
//

import Foundation
import SwiftUI

class FlickrImageViewModel {
    private let model: FlickrImage
    var image: UIImage?
    
    init(flickrImageData: FlickrImage) {
        self.model = flickrImageData
    }
    
    var imageURL: String? {
        model.media["m"]
    }
    
    var title: String {
        model.title
    }
    
    var description: String {
        print("RM: \(model.description)")
        let regex = try? NSRegularExpression(pattern: "(?<=<p>)(.*?)(?=</p>)", options: [])
        if let results = regex?.matches(in: model.description, range: NSRange(location: 0, length: model.description.count)), let matchingResult = results.last, let range = Range(matchingResult.range, in: model.description) {
            return String(model.description[range]).htmlToString ?? ""
        }
        return ""
    }
    
    var author: String {
        model.author
    }
    
    var publishDate: String {
        model.published.formattedDate
    }
}
