//
//  ProductViewModel.swift
//  Fetcher
//
//  Created by taekki on 2023/08/21.
//

import RxCocoa
import RxSwift

final class ProductViewModel {
  
  private var disposeBag = DisposeBag()
  private let productService: ProductProvider
  
  var products = BehaviorSubject<[Product]>(value: [])

  init(productService: ProductProvider = ProductProviderImpl()) {
    self.productService = productService
    
    fetch()
    bind()
  }
  
  private func fetch() {
    // fetch
    productService.fetch()
  }
  
  private func bind() {
    // binding
    productService.products
      .observe(on: MainScheduler.asyncInstance)
      .subscribe(onNext: { products in
        self.products.onNext(products)
      }, onError: { error in
        print(error)
      })
      .disposed(by: disposeBag)
  }
}
