//
//  AppState.swift
//  GithubApi
//
//  Created by Maksym Popovych on 10/10/18.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

import ReSwift

struct AppState: StateType {
    let routingState: RoutingState
    
    let repositoriesTableState: RepositoriesTableState
    let releasesTableState: ReleasesTableState
}
