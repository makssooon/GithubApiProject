//
//  RepositoriesTableViewController.swift
//  GithubApi
//
//  Created by Maksym Popovych on 10/9/18.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

import UIKit

class RepositoriesTableViewController: UITableViewController {

    @IBOutlet private var searchBar : UISearchBar!
    
    private let connectionHelper = ConnectionHelper.shareInstance
    private var githubResponse : GithubSearchRepositoriesResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return githubResponse?.items.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "reuseIdentifier")
        
        cell.textLabel?.text = githubResponse?.items[indexPath.row].repositoryName
        cell.detailTextLabel?.text = githubResponse?.items[indexPath.row].ownerLogin

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let releasesTableViewController: ReleasesTableViewController = storyboard?.instantiateViewController(withIdentifier: "ReleasesTableViewController") as? ReleasesTableViewController else {return}
        releasesTableViewController.repository = githubResponse?.items[indexPath.row]
        self.navigationController?.pushViewController(releasesTableViewController, animated: true)
    }

}

extension RepositoriesTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if ((searchBar.text ?? "").isEmpty) {
            githubResponse = nil
            tableView.reloadData()
            return
        }
        connectionHelper.getRepositories(ForKeyword: searchBar.text!,
                                         onSuccess: { (githubResponse) in
                                            self.githubResponse = githubResponse
                                            self.tableView.reloadData()
        },
                                         onFailure: { (task, error) in
                                            print(error.localizedDescription)
        })
    }
    
}
