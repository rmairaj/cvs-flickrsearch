//
//  FlickrDataModel.swift
//  FlickrSearchEngine
//
//  Created by Mairaj, Rija - The Intersect Group on 2/19/24.
//

import Foundation

struct FlickrDataModel: Codable {
    let items: [FlickrImage]
}

struct FlickrImage: Codable, Hashable {
    let title: String
    let link: String
    let description: String
    let author: String
    let media: [String:String]
    let published: String
}
