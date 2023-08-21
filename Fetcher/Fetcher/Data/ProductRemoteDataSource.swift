//
//  ProductRemoteDataSource.swift
//  Fetcher
//
//  Created by taekki on 2023/08/21.
//

import RxSwift

final class ProductRemoteDataSource {
  private let productService: ProductNetworking
  
  init(productService: ProductNetworking) {
    self.productService = productService
  }
  
  func fetchProducts() -> Observable<[Product]> {
    return productService.request().map(\.products)
  }
}
