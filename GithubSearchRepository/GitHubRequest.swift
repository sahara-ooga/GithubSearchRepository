//
//  GitHubRequest.swift
//  GithubSearchRepository
//
//  Created by yuu ogasawara on 2017/05/25.
//  Copyright © 2017年 stv. All rights reserved.
//

import Foundation

protocol GitHubRequest {
    var baseURL:URL { get }
    var path:String { get }
    var method:HTTPMethod { get } 
}

extension GitHubRequest{
    var baseURL:URL {
        return URL(string: "https://api.github.com")!
    }
}
