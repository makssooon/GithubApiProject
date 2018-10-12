//
//  FetchReleasesAction.swift
//  GithubApi
//
//  Created by Maksym Popovych on 10/10/18.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

import ReSwift

func fetchReleases(for login: String, repository: String) -> FetchReleasesAction {
//    connectionHelper.releases(for: login,
//                              repository: repository,
//                              onSuccess: { githubResponse in
//                                var releases: [ReleaseData] = []
//                                for item in githubResponse {
//                                    releases.append(ReleaseData(name: item.releaseName,
//                                                                body: item.body,
//                                                                authorName: item.authorLogin))
//                                }
//                                store.dispatch(SetReleasesAction(releases: releases))
//    },
//                              onFailure: { error in
//                                print(error)
//                                store.dispatch(SetReleasesAction(releases: []))
//    })
    
    connectionHelper.releases(for: login, repository: repository)
        .done { githubResponse in
            var releases: [ReleaseData] = []
            for item in githubResponse {
                releases.append(ReleaseData(name: item.releaseName,
                                            body: item.body,
                                            authorName: item.authorLogin))
            }
            store.dispatch(SetReleasesAction(releases: releases))
        }.catch { error in
            print(error)
            store.dispatch(SetReleasesAction(releases: []))
    }
    
    return FetchReleasesAction()
}

struct FetchReleasesAction: Action {
    
}
