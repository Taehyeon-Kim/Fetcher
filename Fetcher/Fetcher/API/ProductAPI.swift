//
//  ProductAPI.swift
//  Fetcher
//
//  Created by taekki on 2023/08/21.
//

import Foundation

import Moya

enum ProductAPI {
  case fetchAllProducts
}

extension ProductAPI: TargetType {
  var baseURL: URL {
    switch self {
    case .fetchAllProducts:
      return URL(string: "https://dummyjson.com")!
    }
  }
  
  var path: String {
    switch self {
    case .fetchAllProducts:
      return "/products"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .fetchAllProducts:
      return .get
    }
  }
  
  var task: Moya.Task {
    return .requestPlain
  }
  
  var headers: [String : String]? {
    return nil
  }
}
