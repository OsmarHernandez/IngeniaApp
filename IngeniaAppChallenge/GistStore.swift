//
//  GistStore.swift
//  IngeniaAppChallenge
//
//  Created by Osmar Hernández on 28/08/19.
//  Copyright © 2019 Ingenia. All rights reserved.
//

import Foundation

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
    
    public func getOwnerImage(_ url: URL, completion: @escaping(Data?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        
        task.resume()
    }
}
