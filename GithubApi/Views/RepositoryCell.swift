//
//  RepositoryCell.swift
//  GithubApi
//
//  Created by Maksym Popovych on 10/12/18.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

import AsyncDisplayKit

class RepositoryCell: ASCellNode {

    private var repositoryNameTextNode: ASTextNode
    private var ownerNameTextNode: ASTextNode
    
    init(repositoryData: RepositoryData) {
        repositoryNameTextNode = ASTextNode()
        ownerNameTextNode = ASTextNode()
        super.init()
        
        repositoryNameTextNode.attributedText = NSAttributedString(string: repositoryData.name)
        ownerNameTextNode.attributedText = NSAttributedString(string: repositoryData.ownerName)
        
        addSubnode(repositoryNameTextNode)
        addSubnode(ownerNameTextNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let repositoryNameTextInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0),
                                                            child: repositoryNameTextNode)
        let ownerNameTextInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20.0, left: 10.0, bottom: 10.0, right: 10.0),
                                                         child: ownerNameTextNode)
        let verticalStackSpec = ASStackLayoutSpec()
        verticalStackSpec.direction = .vertical
        verticalStackSpec.children = [repositoryNameTextInsetSpec, ownerNameTextInsetSpec]
        
        return verticalStackSpec
    }
    
}
