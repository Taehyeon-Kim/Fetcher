//
//  ProductService.swift
//  Fetcher
//
//  Created by taekki on 2023/08/21.
//

import Moya
import RxMoya
import RxSwift

final class ProductNetworking: NetworkingType {
  typealias T = ProductAPI
  var provider = MoyaProvider<ProductAPI>()
  
  func request() -> Observable<ProductEntity> {
    return provider.rx
      .request(.fetchAllProducts)
      .map(ProductEntity.self)
      .asObservable()
  }
}
