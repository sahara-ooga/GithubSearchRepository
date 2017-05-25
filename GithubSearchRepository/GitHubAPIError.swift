//
//  GitHubAPIError.swift
//  GithubSearchRepository
//
//  Created by yuu ogasawara on 2017/05/25.
//  Copyright © 2017年 stv. All rights reserved.
//

struct GitHubAPIError:Error,JSONDecodable {
    let message:String
    
    init(json:Any)throws {
        guard let dictionary = json as? [String:Any] else {
            throw JSONDecodeError.invalidFormat(json: json)
        }
        
        guard let message = dictionary["message"] as? String else {
            throw JSONDecodeError.missingValue(key: "message",
                                               actualValue: dictionary["message"])
        }
        
        self.message = message
    }
}
