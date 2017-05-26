//
//  GitHubAPI.swift
//  GithubSearchRepository
//
//  Created by yuu ogasawara on 2017/05/26.
//  Copyright © 2017年 stv. All rights reserved.
//

final class GitHubAPI {
    struct SearchReposidtories:GitHubRequest {
        let keyword:String
        
        // GitHubRequestプロトコルが要求する連想型
        typealias Response = SearchResponse<Repository>
        
        var method: HTTPMethod{
            return .get
        }
        
        var path: String{
            return "/search/repositories"
        }
        
        var parameters: Any?{
            return ["q": keyword]
        }
    }
    
    struct SearchUsers:GitHubRequest {
        let keyword:String
        
        typealias Response = SearchResponse<User>
        
        var method: HTTPMethod{
            return .get
        }
        
        var path: String{
            return "/search/users"
        }
        
        var parameters: Any?{
            return ["q":keyword]
        }
        
    }
}
