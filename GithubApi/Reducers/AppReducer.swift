//
//  AppReducer.swift
//  GithubApi
//
//  Created by Maksym Popovych on 10/10/18.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    print(type(of: action))
    
    return AppState(routingState: routingReducer(action: action, state: state?.routingState),
                    repositoriesTableState: repositoriesTableReducer(action: action, state: state?.repositoriesTableState),
                    releasesTableState: releasesTableReducer(action: action, state: state?.releasesTableState))
}
