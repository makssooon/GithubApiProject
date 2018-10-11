//
//  RepositoriesTableReducer.swift
//  GithubApi
//
//  Created by Maksym Popovych on 10/10/18.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

import ReSwift

func repositoriesTableReducer(action: Action, state: RepositoriesTableState?) -> RepositoriesTableState {
    var state = state ?? RepositoriesTableState()
    switch action {
    case let currentAction as SetRepositoriesAction:
        state.repositories = currentAction.repositories
        state.isLoading = false
    case _ as FetchRepositoriesAction:
        state.isLoading = true
    default:
        break
    }
    
    return state
}
