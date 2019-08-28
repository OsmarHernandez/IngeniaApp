//
//  GistInfo.swift
//  IngeniaAppChallenge
//
//  Created by Osmar Hernández on 28/08/19.
//  Copyright © 2019 Ingenia. All rights reserved.
//

import Foundation

struct Gist {
    var comments: Int = 0
    var login: String = ""
    var fileName: String = ""
    var createdAt: String = ""
    var description: String = ""
    var ownerImageURL: String = ""
    
    init(fileName: String, ownerImageURL: String, login: String, description: String, createdAt: String, comments: Int) {
        self.ownerImageURL = ownerImageURL
        self.description = description
        self.createdAt = createdAt
        self.fileName = fileName
        self.comments = comments
        self.login = login
    }
    
    init() {
        
    }
    
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return df
    }()
    
    var date: Date? {
        return self.dateFormatter.date(from: self.createdAt)
    }
    
    var fileRawValue: String?
}

extension Gist: Equatable {
    static func == (lhs: Gist, rhs: Gist) -> Bool {
        return lhs.date == rhs.date
    }
}
