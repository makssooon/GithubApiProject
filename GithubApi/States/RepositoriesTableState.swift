//
//  RepositoriesTableState.swift
//  GithubApi
//
//  Created by Maksym Popovych on 10/10/18.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

import ReSwift

struct RepositoriesTableState {
    var repositories: [RepositoryData]
    var isLoading: Bool
    
    init(repositories: [RepositoryData] = [], isLoading: Bool = false) {
        self.repositories = repositories
        self.isLoading = isLoading
    }
}
