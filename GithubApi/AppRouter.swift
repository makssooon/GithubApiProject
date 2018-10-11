//
//  AppRouter.swift
//  GithubApi
//
//  Created by Maksym Popovych on 10/10/18.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

import ReSwift

enum RoutingDestination: String {
    case RepositoriesTableViewController = "RepositoriesTableViewController"
    case ReleasesTableViewController = "ReleasesTableViewController"
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
    
    private func pushViewController(identifier: String, animated: Bool) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
        navigationController.pushViewController(viewController, animated: animated)
    }
    
}

extension AppRouter: StoreSubscriber {
    func newState(state: RoutingState) {
        if (navigationController.topViewController?.restorationIdentifier == state.navigationState.rawValue) {
            
            return
        }
        let shouldAnimate = navigationController.topViewController != nil
        pushViewController(identifier: state.navigationState.rawValue, animated: shouldAnimate)
    }
    
}
