//
//  SearchResponse.swift
//  GithubSearchRepository
//
//  Created by yuu ogasawara on 2017/05/25.
//  Copyright © 2017年 stv. All rights reserved.
//

struct SearchResponse<Item> {
    let totalCount:Int
    let items:[Item]
}
