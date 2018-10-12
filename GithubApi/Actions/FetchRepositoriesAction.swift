//
//  FetchRepositoriesAction.swift
//  GithubApi
//
//  Created by Maksym Popovych on 10/10/18.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

import ReSwift

func fetchRepositories(for keyword: String) -> FetchRepositoriesAction {
//    connectionHelper.repositories(for: keyword,
//                                  onSuccess: { githubResponse in
//                                    var repositories: [RepositoryData] = []
//                                    for item in githubResponse.items {
//                                        repositories.append(RepositoryData(name: item.repositoryName,
//                                                                           fullName: item.repositoryFullName,
//                                                                           ownerName: item.ownerLogin))
//                                    }
//                                    store.dispatch(SetRepositoriesAction(repositories: repositories))
//    },
//                                  onFailure: { error in
//                                    print(error)
//                                    store.dispatch(SetRepositoriesAction(repositories: []))
//    })
    
    connectionHelper.repositories(for: keyword)
        .done { githubResponse in
            var repositories: [RepositoryData] = []
            for item in githubResponse.items {
                repositories.append(RepositoryData(name: item.repositoryName,
                                                   fullName: item.repositoryFullName,
                                                   ownerName: item.ownerLogin))
            }
            store.dispatch(SetRepositoriesAction(repositories: repositories))
        }.catch { error in
            print(error)
            store.dispatch(SetRepositoriesAction(repositories: []))
    }
    return FetchRepositoriesAction()
}

struct FetchRepositoriesAction: Action {
    
}
