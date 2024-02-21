//
//  SearchScreenViewModel.swift
//  FlickrSearchEngine
//
//  Created by Mairaj, Rija - The Intersect Group on 2/19/24.
//

import Foundation
import SwiftUI

enum ErrorState {
    case invalidURL
    case serverError
    case parsingError
    case noData
    
    func getCopy() -> String {
        switch self {
        case .invalidURL: return "URL is not valid..."
        case .serverError: return "Oops.. an error occurred"
        case .parsingError: return "There was a parsing error..."
        case .noData: return "No data found for given search"
        }
    }
}

class SearchScreenViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var flickrImageList: [FlickrImage] = []
    @Published var errorState: ErrorState?
    @Published var apiInProgress: Bool = false
    private(set) var previousSearchText: String?
    
    func trimSearchText(_ text: String) -> String {
        var punctuationCharSet = CharacterSet.punctuationCharacters
        punctuationCharSet.remove(charactersIn: ",")
        
        return text.trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: .decimalDigits).trimmingCharacters(in: punctuationCharSet)
    }
    
    func createFlickrRequest(searchString: String) -> URLRequest? {
        let urlStringBase = "https://api.flickr.com/services/feeds/photos_public.gne"
        var queryParams = [URLQueryItem]()
        queryParams.append(URLQueryItem(name: "format", value: "json"))
        queryParams.append(URLQueryItem(name: "nojsoncallback", value: "1"))
        queryParams.append(URLQueryItem(name: "tags", value: searchString))
        if let requestUrl = URL(string: urlStringBase) {
            var request = URLRequest(url: requestUrl)
            request.httpMethod = "GET"
            request.url?.append(queryItems: queryParams)
            request.timeoutInterval = 15
            return request
        }
        return nil
    }
    
    func setInProgressStatus(_ inProgress: Bool) {
        withAnimation(.bouncy, {
            self.apiInProgress = inProgress
        })
    }
    
    func getFlickerImagesForSearchedText() {
        guard previousSearchText != searchText else { return }
        
        self.previousSearchText = searchText
        getFlickerImages(searchText, completion: { images,error in
            DispatchQueue.main.async {
                self.setInProgressStatus(false)
                if let images = images, images.isEmpty {
                    self.errorState = .noData
                }
                self.flickrImageList = images ?? []
            }
            
        })
    }
    
    func getFlickerImages(_ searchText: String, completion: @escaping ([FlickrImage]?, ErrorState?) -> Void) {
        guard let request = createFlickrRequest(searchString: searchText) else {
            completion(nil, .invalidURL)
            return
        }
        print("RM: The request URL is: \(request.url?.absoluteString)")
        self.setInProgressStatus(true)
        NetworkManager.shared.getData(request: request, completion: { result in
            switch result {
            case .success(let data):
                do {
                    let flickrData = try JSONDecoder().decode(FlickrDataModel.self, from: data)
                    print("RM: The response has \(flickrData.items.count) elements")
                    completion(flickrData.items, nil)
                } catch {
                    print(error)
                    completion(nil, .parsingError)
                }
            case .failure(let error):
                print(error)
                completion(nil, .serverError)
            }
        })
    }
}
