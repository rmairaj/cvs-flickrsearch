//
//  NetworkManager.swift
//  FlickrSearchEngine
//
//  Created by Mairaj, Rija - The Intersect Group on 2/20/24.
//

import Foundation
import UIKit

enum APIError: Error {
    case noNetwork
    case serverError(code: Int)
    case unknown
}

class NetworkManager {
    static let shared = NetworkManager()
    
    func getData(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data, error == nil {
                completion(.success(data))
            } else if error != nil {
                if let httpResponse = response as? HTTPURLResponse {
                    completion(.failure(APIError.serverError(code: httpResponse.statusCode)))
                } else {
                    completion(.failure(APIError.unknown))
                }
            }
        }.resume()
    }
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = ImageCache.shared.get(forKey: urlString) {
            completion(cachedImage)
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data, error == nil  else { return }
            guard let image = UIImage(data: data) else { return }
            ImageCache.shared.set(image, forKey: urlString)
            completion(image)
        }).resume()
    }
}
