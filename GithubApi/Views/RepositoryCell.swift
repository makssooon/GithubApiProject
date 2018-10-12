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
        let repositoryNameRelativeSpec = ASRelativeLayoutSpec(horizontalPosition: .start,
                                                              verticalPosition: .start,
                                                              sizingOption: .init(rawValue: 0),
                                                              child: repositoryNameTextNode)
        let repositoryNameInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: CGFloat.infinity),
                                                        child: repositoryNameRelativeSpec)
        
        let ownerNameRelativeSpec = ASRelativeLayoutSpec(horizontalPosition: .end,
                                                         verticalPosition: .end,
                                                         sizingOption: .minimumSize,
                                                         child: ownerNameTextNode)
        let ownerNameInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8.0, left: CGFloat.infinity, bottom: 8.0, right: 8.0),
                                                       child: ownerNameRelativeSpec)
        let verticalStackSpec = ASStackLayoutSpec()
        verticalStackSpec.direction = .vertical
        verticalStackSpec.children = [repositoryNameInsetSpec, ownerNameInsetSpec]
        
        return verticalStackSpec
    }
    
}
