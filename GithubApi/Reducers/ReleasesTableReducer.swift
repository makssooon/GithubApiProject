//
//  ReleasesTableReducer.swift
//  GithubApi
//
//  Created by Maksym Popovych on 10/10/18.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

import ReSwift

func releasesTableReducer(action: Action, state: ReleasesTableState?) -> ReleasesTableState {
    var state = state ?? ReleasesTableState()
    switch action {
    case let currentAction as SetReleasesAction:
        state.releases = currentAction.releases
        state.isLoading = false
    case _ as FetchReleasesAction:
        state.isLoading = true
    default:
        break
    }
    
    return state
}
