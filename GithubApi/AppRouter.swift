//
//  AppRouter.swift
//  GithubApi
//
//  Created by Maksym Popovych on 10/10/18.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

import ReSwift

enum RoutingDestination: String {
//    case RepositoriesTableViewController = "RepositoriesTableViewController"
//    case ReleasesTableViewController = "ReleasesTableViewController"
    
    case RepositoriesTableController = "RepositoriesTableController"
    case ReleasesTableController = "ReleasesTableController"
}

final class AppRouter {
    let navigationController: UINavigationController
    
    init(window: UIWindow) {
        navigationController = UINavigationController()
        window.rootViewController = navigationController
        
        store.subscribe(self) {
            $0.select {
                $0.routingState
            }
        }
    }
    
    private func pushViewController(identifier: RoutingDestination, animated: Bool) {
        navigationController.pushViewController(viewController(for: identifier), animated: animated)
    }
    
    private func viewController(for identifier: RoutingDestination) -> UIViewController {
        switch identifier {
        case .RepositoriesTableController:
            return RepositoriesTableController(repositories: [])
        case .ReleasesTableController:
            return ReleasesTableController(releases: [])
        }
    }
    
}

extension AppRouter: StoreSubscriber {
    func newState(state: RoutingState) {
        if (navigationController.topViewController?.restorationIdentifier == state.navigationState.rawValue) {
            
            return
        }
        let shouldAnimate = navigationController.topViewController != nil
        pushViewController(identifier: state.navigationState, animated: shouldAnimate)
    }
    
}
