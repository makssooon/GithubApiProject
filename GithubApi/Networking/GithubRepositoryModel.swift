//
//  GithubRepositoryModel.swift
//  GithubApi
//
//  Created by Maksym Popovych on 10/9/18.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

import Foundation

struct GithubRepositoryModel: Decodable {
    let repositoryName: String
    let repositoryFullName: String
    
    let ownerLogin: String
    
    enum CodingKeys: String, CodingKey {
        case repositoryName = "name"
        case repositoryFullName = "full_name"
        case owner = "owner"
    }
    
    enum OwnerCodingKeys: String, CodingKey {
        case ownerLogin = "login"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.repositoryName = try container.decode(String.self, forKey: .repositoryName)
        self.repositoryFullName = try container.decode(String.self, forKey: .repositoryFullName)
        
        let ownerContainer = try container.nestedContainer(keyedBy: OwnerCodingKeys.self, forKey: .owner)
        self.ownerLogin = try ownerContainer.decode(String.self, forKey: .ownerLogin)
    }
}
