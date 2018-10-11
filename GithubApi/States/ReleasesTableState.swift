//
//  ReleasesTableState.swift
//  GithubApi
//
//  Created by Maksym Popovych on 10/10/18.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

import ReSwift

struct ReleasesTableState: StateType {
    var releases: [ReleaseData]
    var isLoading: Bool
    
    init(releases: [ReleaseData] = [], isLoading: Bool = false) {
        self.releases = releases
        self.isLoading = isLoading
    }
}
