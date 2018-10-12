//
//  ReleaseCell.swift
//  GithubApi
//
//  Created by Maksym Popovych on 10/12/18.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

import AsyncDisplayKit

class ReleaseCell: ASCellNode {
    
    private var releaseNameTextNode: ASTextNode
    private var authorNameTextNode: ASTextNode
    private var releaseBodyTextNode: ASTextNode
    
    init(releaseData: ReleaseData) {
        releaseNameTextNode = ASTextNode()
        authorNameTextNode = ASTextNode()
        releaseBodyTextNode = ASTextNode()
        super.init()
        
        releaseNameTextNode.attributedText = NSAttributedString(string: releaseData.name)
        authorNameTextNode.attributedText = NSAttributedString(string: releaseData.authorName)
        releaseBodyTextNode.attributedText = NSAttributedString(string: releaseData.body)
        
        addSubnode(releaseNameTextNode)
        addSubnode(authorNameTextNode)
        addSubnode(releaseBodyTextNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let releaseNameTextInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0),
                                                            child: releaseNameTextNode)
        let authorNameTextInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20.0, left: 10.0, bottom: 10.0, right: 10.0),
                                                       child: authorNameTextNode)
        let releaseBodyTextInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 40.0, left: 10.0, bottom: 10.0, right: 10.0),
                                                        child: releaseBodyTextNode)
        let verticalStackSpec = ASStackLayoutSpec()
        verticalStackSpec.direction = .vertical
        verticalStackSpec.children = [releaseNameTextInsetSpec, authorNameTextInsetSpec, releaseBodyTextInsetSpec]
        
        return verticalStackSpec
    }
    
}
