//
//  GistStore.swift
//  IngeniaAppChallenge
//
//  Created by Osmar Hernández on 28/08/19.
//  Copyright © 2019 Ingenia. All rights reserved.
//

import Foundation
import UIKit

enum GistsResult {
    case success([Gist])
    case failure(Error)
}

class GistStore {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    private func processRequest(data: Data?, error: Error?) -> GistsResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        
        return GistsAPI.getGists(fromJSON: jsonData)
    }
    
    public func fetchingGists(completion: @escaping (GistsResult) -> Void) {
        guard GistsAPI.gistsURL != nil else { return }
        
        let task = session.dataTask(with: GistsAPI.gistsURL!) {
            (data, response, error) in
            
            let result = self.processRequest(data: data, error: error)
            
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        task.resume()
    }
    
    public func getOwnerImage(with stringURL: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: stringURL) else { return }
        
        let task = session.dataTask(with: url) {
            (data, response, error) in
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            let downloadedImage = UIImage(data: data)
            
            DispatchQueue.main.async {
                completion(downloadedImage)
            }
        }
        
        task.resume()
    }
}
