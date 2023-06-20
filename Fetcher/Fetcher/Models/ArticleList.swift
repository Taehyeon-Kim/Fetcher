//
//  ArticleList.swift
//  Fetcher
//
//  Created by taekki on 2023/06/20.
//

import Foundation

struct ArticleList: Decodable {
    
    struct Article: Decodable {
        let title: String
        let summary: String
        let country: String
    }
    
    let status: String
    let totalHits: Int
    let page: Int
    let totalPages: Int
    let pageSize: Int
    let articles: [Article]
    
    enum CodingKeys: String, CodingKey {
        case status
        case totalHits = "total_hits"
        case page
        case totalPages = "total_pages"
        case pageSize = "page_size"
        case articles
    }
}
