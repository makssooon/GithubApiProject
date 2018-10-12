//
//  RepositoriesTableViewController.swift
//  GithubApi
//
//  Created by Maksym Popovych on 10/9/18.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

//import UIKit
//import ReSwift
//
//class RepositoriesTableViewController: UITableViewController {
//
//    @IBOutlet private var searchBar : UISearchBar!
//    
//    private var activityIndicatorViewController:  ActivityIndicatorController?
//    private var repositories : [RepositoryData]?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        activityIndicatorViewController = ActivityIndicatorController(viewController: self)
//        searchBar.delegate = self
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        store.subscribe(self) {
//            $0.select {
//                $0.repositoriesTableState
//            }
//        }
//        store.dispatch(RoutingAction(destination: .RepositoriesTableViewController))
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        store.unsubscribe(self)
//    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        return repositories?.count ?? 0
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") ??
//            UITableViewCell(style: .subtitle, reuseIdentifier: "reuseIdentifier")
//        cell.textLabel?.text = repositories?[indexPath.row].name
//        cell.detailTextLabel?.text = repositories?[indexPath.row].ownerName
//
//        return cell
//    }
//    
//    // MARK: - Table view delegate
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        store.dispatch(fetchReleases(for: repositories![indexPath.row].ownerName, repository: repositories![indexPath.row].name))
//        store.dispatch(RoutingAction(destination: .ReleasesTableViewController))
//    }
//
//}
//
//extension RepositoriesTableViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.resignFirstResponder()
//        if (searchBar.text ?? "").isEmpty {
//            store.dispatch(SetRepositoriesAction(repositories: []))
//        } else {
//            store.dispatch(fetchRepositories(for: searchBar.text!))
//        }
//        
//    }
//    
//}
//
//extension RepositoriesTableViewController: StoreSubscriber {
//    func newState(state: RepositoriesTableState) {
//        repositories = state.repositories
//        if (state.isLoading) {
//            activityIndicatorViewController?.spinner.startAnimating()
//        } else {
//            activityIndicatorViewController?.spinner.stopAnimating()
//        }
//        tableView.reloadData()
//    }
//    
//}
