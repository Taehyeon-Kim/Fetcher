//
//  DBClient.swift
//  Fetcher
//
//  Created by taekki on 2023/06/20.
//

import Foundation

/**
  - 로컬 저장소(Local Storage)와 Communication 하는 객체
  - Realm, Core Data, ... 등과 통신 할 수 있음
 */
struct LocalClient {
  var list: ArticleList?
  
  func getArticleOnLocal() -> ArticleList {
    return .init(
      status: "ok",
      totalHits: 20,
      page: 20,
      totalPages: 20,
      pageSize: 20,
      articles: [
        .init(title: "로컬 아티클 1", summary: "blah blah blah", country: "Ko"),
        .init(title: "로컬 아티클 2", summary: "blah blah blah", country: "US"),
        .init(title: "로컬 아티클 3", summary: "blah blah blah", country: "UK"),
      ]
    )
  }
}
