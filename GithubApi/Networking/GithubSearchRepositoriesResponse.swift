//
//  GithubSearchRepositoriesResponse.swift
//  GithubApi
//
//  Created by Maksym Popovych on 10/9/18.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

import Foundation

struct GithubSearchRepositoriesResponse: Decodable {
    let repositoriesCount: Int
    let items: [GithubRepositoryModel]
    
    enum CodingKeys: String, CodingKey {
        case repositoriesCount = "total_count"
        case items = "items"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.repositoriesCount = try container.decode(Int.self, forKey: .repositoriesCount)
        self.items = try container.decode([GithubRepositoryModel].self, forKey: .items)
    }
    
    init() {
        repositoriesCount = 0
        items = []
    }
}
