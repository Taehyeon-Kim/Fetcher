//
//  HttpClient.swift
//  Fetcher
//
//  Created by taekki on 2023/06/20.
//

import Foundation
import RxSwift

/**
  - 원격 저장소(Remote Storage)와 Communication 하는 객체
  
 */
struct HttpClient {
  /// 세션
  var session = URLSession.shared
  
  /// async/await 사용해서 데이터 패치
  func fetchArticleList() async throws -> ArticleList {
    let url = URL(string: Config.urlString)!
    var request = URLRequest(url: url)
    request.addValue(Secrets.apiKey, forHTTPHeaderField: "x-api-key")
    
    let (data, _) = try await session.data(for: request)
    let decoder = JSONDecoder()
    return try decoder.decode(ArticleList.self, from: data)
  }
  
  /// RxSwift Single 사용해서 데이터 패치
  func fetchArticleListOnSingle() -> Single<ArticleList> {
    let url = URL(string: Config.urlString)!
    var request = URLRequest(url: url)
    request.addValue(Secrets.apiKey, forHTTPHeaderField: "x-api-key")
    
    return Single.create { single in
      session.dataTask(with: request) { data, response, error in
        guard error == nil,
              let response = (response as? HTTPURLResponse),
              (200..<500) ~= response.statusCode
        else {
          return
        }
        
        guard let data = data else {
          return
        }
        
        let decoder = JSONDecoder()
        do {
          let decodedData = try decoder.decode(ArticleList.self, from: data)
          single(.success(decodedData))
          return
        } catch {
          single(.failure(error))
          return
        }
      }.resume()
      
      return Disposables.create()
    }
  }
}
