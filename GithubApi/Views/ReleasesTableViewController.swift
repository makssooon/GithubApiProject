//
//  ReleasesTableViewController.swift
//  GithubApi
//
//  Created by Maksym Popovych on 10/9/18.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

//import UIKit
//import ReSwift
//
//class ReleasesTableViewController: UITableViewController {
//    
//    private var activityIndicatorViewController:  ActivityIndicatorController?
//    private var releases: [ReleaseData]?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        activityIndicatorViewController = ActivityIndicatorController(viewController: self)
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        store.subscribe(self) {
//            $0.select {
//                $0.releasesTableState
//            }
//        }
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        releases = []
//        tableView.reloadData()
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
//        return releases?.count ?? 0
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ReleaseTableViewCell") as? ReleaseTableViewCell ??
//            ReleaseTableViewCell()
//        let release = releases![indexPath.row]
//        cell.set(releaseName: release.name, authorLogin: release.authorName, body: release.body)
//
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        return 150
//    }
//    
//}
//
//extension ReleasesTableViewController: StoreSubscriber {
//    func newState(state: ReleasesTableState) {
//        releases = state.releases
//        if (state.isLoading) {
//            activityIndicatorViewController?.spinner.startAnimating()
//        } else {
//            activityIndicatorViewController?.spinner.stopAnimating()
//        }
//        tableView.reloadData()
//    }
//    
//}
