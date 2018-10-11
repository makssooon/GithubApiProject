//
//  RoutingReducer.swift
//  GithubApi
//
//  Created by Maksym Popovych on 10/10/18.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

import ReSwift

func routingReducer(action: Action, state: RoutingState?) -> RoutingState {
    var state = state ?? RoutingState()
    switch action {
    case let currentAction as RoutingAction:
        state.navigationState = currentAction.destination
    default:
        break
    }
    
    return state
}
