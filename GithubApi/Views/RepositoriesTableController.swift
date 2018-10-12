//
//  RepositoriesTableController.swift
//  GithubApi
//
//  Created by Maksym Popovych on 10/12/18.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

import AsyncDisplayKit
import ReSwift

class RepositoriesTableController: ASViewController<ASTableNode> {
    
    private let tableNode: ASTableNode
    private var activityIndicatorController: ActivityIndicatorController?
    private var searchController: UISearchController?
    private var repositories : [RepositoryData]?

    init(repositories: [RepositoryData]) {
        let tableNode = ASTableNode(style: .plain)
        self.tableNode = tableNode
        super.init(node: tableNode)
        
        self.tableNode.dataSource = self
        self.tableNode.delegate = self
        self.repositories = repositories
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restorationIdentifier = "RepositoriesTableController"
        activityIndicatorController = ActivityIndicatorController(viewController: self)
        searchController = UISearchController(searchResultsController: nil)
        searchController?.dimsBackgroundDuringPresentation = false
        searchController?.searchResultsUpdater = self
        searchController?.searchBar.sizeToFit()
        searchController?.searchBar.searchBarStyle = .minimal
        searchController?.searchBar.delegate = self
        view.addSubview(searchController!.searchBar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self) {
            $0.select {
                $0.repositoriesTableState
            }
        }
        store.dispatch(RoutingAction(destination: .RepositoriesTableController))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }

}

extension RepositoriesTableController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        
        return repositories?.count ?? 0
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cell = RepositoryCell(repositoryData: repositories![indexPath.row])
        
        return {
            return cell
        }
    }
    
}

extension RepositoriesTableController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        tableNode.deselectRow(at: indexPath, animated: true)
        store.dispatch(fetchReleases(for: repositories![indexPath.row].ownerName, repository: repositories![indexPath.row].name))
        store.dispatch(RoutingAction(destination: .ReleasesTableController))
    }
    
}

extension RepositoriesTableController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}

extension RepositoriesTableController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController?.resignFirstResponder()
        if (searchBar.text ?? "").isEmpty {
            store.dispatch(SetRepositoriesAction(repositories: []))
        } else {
            store.dispatch(fetchRepositories(for: searchBar.text!))
        }
    }
    
}

extension RepositoriesTableController: StoreSubscriber {
    func newState(state: RepositoriesTableState) {
        repositories = state.repositories
        if (state.isLoading) {
            activityIndicatorController?.spinner.startAnimating()
        } else {
            activityIndicatorController?.spinner.stopAnimating()
        }
        tableNode.reloadData()
    }
    
}
