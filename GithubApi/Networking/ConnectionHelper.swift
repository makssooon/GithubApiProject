//
//  ConnectionHelper.swift
//  GithubApi
//
//  Created by Maksym Popovych on 10/9/18.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

import PromiseKit

class ConnectionHelper: NSObject {

    private static let instance = ConnectionHelper()
    static var shareInstance : ConnectionHelper {
        return instance
    }
    
    private let session: URLSession
    private let decoder = JSONDecoder()
    
    override init() {
        session = URLSession.shared
    }
    
//    func repositories(for keyword: String,
//                      onSuccess: @escaping (GithubSearchRepositoriesResponse) -> Void,
//                      onFailure : @escaping (Error) -> Void) {
//        let urlString = "https://api.github.com/search/repositories?q=\(keyword)"
//        guard let url = URL(string: urlString) else {
//            let error = NSError(
//                domain: "\(type(of: self)).repositories(for:onSuccess:onFailure:)",
//                code: 0,
//                userInfo: ["url creating error": urlString])
//            onFailure(error)
//            return
//        }
//        let urlRequest = URLRequest(url: url)
//        
//        firstly {
//            session.dataTask(.promise, with: urlRequest)
//        }.done { data, _ in
//            if let githubResponse : GithubSearchRepositoriesResponse = try?
//                JSONDecoder().decode(GithubSearchRepositoriesResponse.self, from: data) {
//                onSuccess(githubResponse)
//            } else {
//                let error = NSError(
//                    domain: "\(type(of: self)).repositories(for:onSuccess:onFailure:)",
//                    code: 0,
//                    userInfo: ["json creating error": urlString])
//                onFailure(error)
//            }
//        }.catch { error in
//            onFailure(error)
//        }
//    }
//    
//    func releases(for owner: String,
//                  repository: String,
//                  onSuccess: @escaping ([GithubReleaseModel]) -> Void,
//                  onFailure : @escaping (Error) -> Void) {
//        let urlString = "https://api.github.com/repos/\(owner)/\(repository)/releases"
//        guard let url = URL(string: urlString) else {
//            let error = NSError(
//                domain: "\(type(of: self)).releases(for:repository:onSuccess:onFailure:)",
//                code: 0,
//                userInfo: ["url creating error": urlString])
//            onFailure(error)
//            return
//        }
//        let urlRequest = URLRequest(url: url)
//        
//        firstly {
//            session.dataTask(.promise, with: urlRequest)
//        }.done { data, _ in
//            if let githubResponse : [GithubReleaseModel] = try?
//                JSONDecoder().decode([GithubReleaseModel].self, from: data) {
//                onSuccess(githubResponse)
//            } else {
//                let error = NSError(
//                    domain: "\(type(of: self)).releases(for:repository:onSuccess:onFailure:)",
//                    code: 0,
//                    userInfo: ["json creating error": urlString])
//                onFailure(error)
//            }
//        }.catch { error in
//            onFailure(error)
//        }
//    }
    
    func repositories(for keyword: String) -> Promise<GithubSearchRepositoriesResponse> {
        let queue = DispatchQueue.global(qos: .default)
        return Promise { resolver in
            queue.async {
                let urlString = "https://api.github.com/search/repositories?q=\(keyword)"
                guard let url = URL(string: urlString) else {
                    let error = NSError(
                        domain: "\(type(of: self)).repositories(for:)",
                        code: 0,
                        userInfo: ["url creating error": urlString])
                    resolver.reject(error)
                    return
                }
                
                self.session.dataTask(.promise, with: url)
                    .map(on: queue) {
                    try JSONDecoder().decode(GithubSearchRepositoriesResponse.self, from: $0.data)
                    }.done(on: queue) {
                        resolver.fulfill($0)
                    }.catch(on: queue) {
                        resolver.reject($0)
                }
            }
        }
    }
    
    func releases(for owner: String, repository: String) -> Promise<[GithubReleaseModel]> {
        let queue = DispatchQueue.global(qos: .default)
        return Promise { resolver in
            queue.async {
                let urlString = "https://api.github.com/repos/\(owner)/\(repository)/releases"
                guard let url = URL(string: urlString) else {
                    let error = NSError(
                        domain: "\(type(of: self)).releases(for:repository:)",
                        code: 0,
                        userInfo: ["url creating error": urlString])
                    resolver.reject(error)
                    return
                }
                
                self.session.dataTask(.promise, with: url)
                    .map(on: queue) {
                        try JSONDecoder().decode([GithubReleaseModel].self, from: $0.data)
                    }.done(on: queue) {
                        resolver.fulfill($0)
                    }.catch(on: queue) {
                        resolver.reject($0)
                }
            }
        }
    }
    
}
