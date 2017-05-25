//
//  GitHubClientError.swift
//  GithubSearchRepository
//
//  Created by yuu ogasawara on 2017/05/25.
//  Copyright © 2017年 stv. All rights reserved.
//

enum GitHubClientError:Error {
    case connetionError(Error)
    case responseParseError(Error)
    case apiError(GitHubAPIError)
}
