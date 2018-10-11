//
//  GithubReleaseModel.swift
//  GithubApi
//
//  Created by Maksym Popovych on 10/9/18.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

import Foundation

struct GithubReleaseModel: Decodable {
    let releaseName: String
    let body: String
    
    let authorLogin: String
    
    enum CodingKeys: String, CodingKey {
        case releaseName = "name"
        case body = "body"
        case author = "author"
    }
    
    enum AuthorCodingKeys: String, CodingKey {
        case authorLogin = "login"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.releaseName = try container.decode(String.self, forKey: .releaseName)
        self.body = try container.decode(String.self, forKey: .body)
        
        let ownerContainer = try container.nestedContainer(keyedBy: AuthorCodingKeys.self, forKey: .author)
        self.authorLogin = try ownerContainer.decode(String.self, forKey: .authorLogin)
    }
}
