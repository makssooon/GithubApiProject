//
//  ReleasesTableController.swift
//  GithubApi
//
//  Created by Maksym Popovych on 10/12/18.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

import AsyncDisplayKit
import ReSwift

class ReleasesTableController: ASViewController<ASTableNode> {
    
    private let tableNode: ASTableNode
    private var activityIndicatorController: ActivityIndicatorController?
    private var releases: [ReleaseData]?
    
    init(releases: [ReleaseData]) {
        let tableNode = ASTableNode(style: .plain)
        self.tableNode = tableNode
        super.init(node: tableNode)
        
        self.tableNode.dataSource = self
        self.tableNode.delegate = self
        self.releases = releases
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restorationIdentifier = "ReleasesTableController"
        activityIndicatorController = ActivityIndicatorController(viewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self) {
            $0.select {
                $0.releasesTableState
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }

}

extension ReleasesTableController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        
        return releases?.count ?? 0
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cell = ReleaseCell(releaseData: releases![indexPath.row])
        
        return {
            return cell
        }
    }
    
}

extension ReleasesTableController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        
        return false
    }
    
}

extension ReleasesTableController: StoreSubscriber {
    func newState(state: ReleasesTableState) {
        releases = state.releases
        if (state.isLoading) {
            activityIndicatorController?.spinner.startAnimating()
        } else {
            activityIndicatorController?.spinner.stopAnimating()
        }
        tableNode.reloadData()
    }
    
}
