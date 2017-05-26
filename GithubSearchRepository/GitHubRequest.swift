//
//  GitHubRequest.swift
//  GithubSearchRepository
//
//  Created by yuu ogasawara on 2017/05/25.
//  Copyright © 2017年 stv. All rights reserved.
//

import Foundation

protocol GitHubRequest {
    associatedtype Response: JSONDecodable
    
    var baseURL:URL { get }
    var path:String { get }
    var method:HTTPMethod { get }
    
    //パラメータが必須でないAPIがあるのでオプショナル型
    var parameters:Any? { get }
    
}

extension GitHubRequest{
    var baseURL:URL {
        return URL(string: "https://api.github.com")!
    }
    
    func buildURLRequest() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        switch method {
        case .get:
            let dictionary = parameters as? [String:Any]
            let queryItems = dictionary?.map{
                key,value in
                return URLQueryItem(name: key, value: String(describing: value))
            }
            components?.queryItems = queryItems
        default:
            fatalError("Unsupported method \(method)")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.url = components?.url
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
    
    func response(from data:Data,
                  urlResponse:URLResponse) throws -> Response {
        //取得したデータをJSONに変換
        let json = try JSONSerialization.jsonObject(with: data,
                                                    options: [])
        
        if case (200..<300)? = (urlResponse as? HTTPURLResponse)?.statusCode {
            //JSONからモデルをインスタンス化
            return try Response(json: json)
        } else {
            //JSONからAPIエラーをインスタンス化
            throw try GitHubAPIError(json: json)
        }
    }
}
