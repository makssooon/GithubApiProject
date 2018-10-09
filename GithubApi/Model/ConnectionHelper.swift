//
//  ConnectionHelper.swift
//  GithubApi
//
//  Created by Maksym Popovych on 10/9/18.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

import UIKit

class ConnectionHelper: NSObject {

    private static let instance = ConnectionHelper()
    static var shareInstance : ConnectionHelper {
        return instance
    }
    
    private var manager : AFHTTPSessionManager!
    private var urlString = "https://api.github.com/"
    private let decoder = JSONDecoder()
    
    override init() {
        let url = URL(string: urlString)
        manager = AFHTTPSessionManager(baseURL: url)
    }
    
    func getRepositories(ForKeyword keyword: String,
                         onSuccess: @escaping (GithubSearchRepositoriesResponse) -> Void,
                         onFailure : @escaping (URLSessionDataTask?, Error) -> Void) {
        manager.get("search/repositories",
                    parameters: ["q" : keyword],
                    progress: { (progress) in
        },
                    success: { (task, responseObject) in
                        guard let responseObject = responseObject else {return}
                        let dataJson = try! JSONSerialization.data(withJSONObject: responseObject, options: JSONSerialization.WritingOptions.prettyPrinted)
                        let githubResponse : GithubSearchRepositoriesResponse = try! JSONDecoder().decode(GithubSearchRepositoriesResponse.self, from: dataJson)
                        
                        onSuccess(githubResponse)
        },
                    failure: { (task, err) in
                        onFailure(task, err)
        })
    }
    
    func getReleases(ForOwner owner: String,
                     repository: String,
                     onSuccess: @escaping ([GithubReleaseModel]) -> Void,
                     onFailure : @escaping (URLSessionDataTask?, Error) -> Void) {
        manager.get("repos/" + owner + "/" + repository + "/releases",
                    parameters: nil,
                    progress: { (progress) in
        },
                    success: { (task, responseObject) in
                        guard let responseObject = responseObject else {return}
                        let dataJson = try! JSONSerialization.data(withJSONObject: responseObject, options: JSONSerialization.WritingOptions.prettyPrinted)
                        let githubResponse : [GithubReleaseModel] = try! JSONDecoder().decode([GithubReleaseModel].self, from: dataJson)
                        
                        onSuccess(githubResponse)
        },
                    failure: { (task, err) in
                        onFailure(task, err)
        })
    }
    
}
