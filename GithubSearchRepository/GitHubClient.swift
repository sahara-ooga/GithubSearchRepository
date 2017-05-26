//
//  GitHubClient.swift
//  GithubSearchRepository
//
//  Created by yuu ogasawara on 2017/05/26.
//  Copyright © 2017年 stv. All rights reserved.
//

import Foundation

class GitHubClinet {
    private let session:URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    func send<Request:GitHubRequest>(request:Request,
              completion:@escaping (Result<Request.Response, GitHubClientError>) -> Void){
        
        let urlRequest = request.buildURLRequest()
        
        let task = session.dataTask(with: urlRequest,
                                    completionHandler: {data,response,error in
                                        
                                        switch (data,response,error){
                                        case (_, _, let error?):
                                            completion(Result(error: .connectionError(error)))
                                            
                                        case (let data?, let response?, _):
                                            do {
                                                let response = try request.response(from: data,
                                                                                    urlResponse: response)
                                                completion(Result(value: response))
                                            } catch let error as GitHubAPIError{
                                                completion(Result(error: .apiError(error)))
                                            } catch{
                                                completion(Result(error: .responseParseError(error)))
                                            }
                                            
                                        default:
                                            fatalError("invalid response combination \(String(describing: data)), \(String(describing: response)), \(String(describing: error)).)")
                                        }
        })
        
            task.resume()
    }
}
