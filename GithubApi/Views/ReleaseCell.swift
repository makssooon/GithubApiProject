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
        let releaseNameRelativeSpec = ASRelativeLayoutSpec(horizontalPosition: .center,
                                                           verticalPosition: .start,
                                                           sizingOption: .init(rawValue: 0),
                                                           child: releaseNameTextNode)
        let releaseNameInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: CGFloat.infinity),
                                                     child: releaseNameRelativeSpec)
        let authorNameRelativeSpec = ASRelativeLayoutSpec(horizontalPosition: .end,
                                                           verticalPosition: .start,
                                                           sizingOption: .init(rawValue: 0),
                                                           child: authorNameTextNode)
        let authorNameInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8.0, left: CGFloat.infinity, bottom: 8.0, right: 8.0),
                                                       child: authorNameRelativeSpec)
        let releaseBodyInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0),
                                                        child: releaseBodyTextNode)
        let verticalStackSpec = ASStackLayoutSpec()
        verticalStackSpec.direction = .vertical
        verticalStackSpec.children = [releaseNameInsetSpec, authorNameInsetSpec, releaseBodyInsetSpec]
        
        return verticalStackSpec
    }
    
}
