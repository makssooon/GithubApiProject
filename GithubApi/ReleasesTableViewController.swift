//
//  ReleasesTableViewController.swift
//  GithubApi
//
//  Created by Maksym Popovych on 10/9/18.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

import UIKit

class ReleasesTableViewController: UITableViewController {
    
    private let connectionHelper = ConnectionHelper.shareInstance
    private var githubResponse: [GithubReleaseModel]?
    
    var repository: GithubRepositoryModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        if (repository != nil) {
            connectionHelper.getReleases(ForOwner: repository!.ownerLogin,
                                         repository: repository!.repositoryName,
                                         onSuccess: { (githubResponse) in
                                            self.githubResponse = githubResponse
                                            self.tableView.reloadData()
            },
                                         onFailure: { (task, error) in
                                            print(error.localizedDescription)
            })
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return githubResponse?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReleaseTableViewCell")! as! ReleaseTableViewCell
        
        let release = githubResponse![indexPath.row]
        cell.set(releaseName: release.releaseName, authorLogin: release.authorLogin, body: release.body)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
    
}
