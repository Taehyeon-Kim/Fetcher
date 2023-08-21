//
//  ProductLocalDataSource.swift
//  Fetcher
//
//  Created by taekki on 2023/08/21.
//

import RxSwift

class ProductLocalDataSource {
  func fetchProducts() -> ObservableProductData? {
    // return nil
    
    return Observable.just([
      .init(id: 20, title: "테스트 상품 1", description: "설명란 1", price: 200, brand: "Apple"),
      .init(id: 20, title: "테스트 상품 2", description: "설명란 2", price: 200, brand: "Apple"),
      .init(id: 20, title: "테스트 상품 3", description: "설명란 3", price: 200, brand: "Apple"),
      .init(id: 20, title: "테스트 상품 4", description: "설명란 4", price: 200, brand: "Apple"),
      .init(id: 20, title: "테스트 상품 5", description: "설명란 5", price: 200, brand: "Apple")
    ])
  }
  
  func saveProducts(_ items: ObservableProductData) {
    print("save items: \(items)")
  }
}
