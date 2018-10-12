//
//  ActivityIndicatorViewController.swift
//  GithubApi
//
//  Created by Maksym Popovych on 10/11/18.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

import UIKit

class ActivityIndicatorController: NSObject {
    
    let loadingView = UIView()
    let spinner = UIActivityIndicatorView()
    
    init(viewController: UIViewController) {
        let width: CGFloat = 30
        let height: CGFloat = 30
        let x = (viewController.view.frame.width / 2) - (width / 2)
        let y = (viewController.view.frame.height / 2) - (height / 2) -
            (viewController.navigationController?.navigationBar.frame.height ?? 0)
        loadingView.frame = CGRect(x: x, y: y, width: width, height: height)
        spinner.style = .gray
        spinner.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        spinner.hidesWhenStopped = true
        loadingView.addSubview(spinner)
        viewController.view.addSubview(loadingView)
    }
    
}
