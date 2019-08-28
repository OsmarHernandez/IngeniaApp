//
//  GistsAPI.swift
//  IngeniaAppChallenge
//
//  Created by Osmar Hernández on 28/08/19.
//  Copyright © 2019 Ingenia. All rights reserved.
//

import Foundation

enum GistsError: Error {
    case invalidJSONData
}

struct GistsAPI {
    
    private static let baseURLString = "https://api.github.com/gists/public"
    static let gistsURL = URL(string: GistsAPI.baseURLString)
    
    static func getGists(fromJSON data: Data) -> GistsResult {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let jsonDictionary = jsonObject as? [[String : Any]] else {
                return .failure(GistsError.invalidJSONData)
            }
            
            var gists = [Gist]()
            
            for dictionary in jsonDictionary {
                if let gist = GistsAPI.gist(from: dictionary) {
                    gists.append(gist)
                }
            }
            
            return .success(gists)
        } catch let error {
            return .failure(error)
        }
    }
    
    private static func gist(from dictionary: [String: Any]) -> Gist? {

        guard
            let files = dictionary["files"] as? [AnyHashable : Any],
            let owner = dictionary["owner"] as? [AnyHashable : Any],
            let description = dictionary["description"] as? String,
            let createdAt = dictionary["created_at"] as? String,
            let comments = dictionary["comments"] as? Int else {
            return nil
        }
        
        var rawValue = ""
        
        var fileName: String {
            var fn: String? = ""
            for (key, value) in files {
                fn = key as? String
                if let value = value as? [String : Any] {
                    rawValue = value["raw_url"] as! String
                }
            }
            return fn ?? ""
        }
        
        var ownerImageURL: String {
            return owner["avatar_url"] as? String ?? ""
        }
        
        var login: String {
            return owner["login"] as? String ?? ""
        }
        
        var gist = Gist(fileName: fileName, ownerImageURL: ownerImageURL, login: login,
                    description: description, createdAt: createdAt, comments: comments)
        gist.fileRawValue = rawValue
        
        return gist
    }
}
