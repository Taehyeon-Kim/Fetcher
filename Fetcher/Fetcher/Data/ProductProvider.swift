//
//  ProductProvider.swift
//  Fetcher
//
//  Created by taekki on 2023/08/21.
//

import RxSwift

protocol ProductProvider {
  var products: BehaviorSubject<[Product]> { get }
  
  func fetch()
}

final class ProductProviderImpl: ProductProvider {
  private let disposeBag = DisposeBag()
  var products = BehaviorSubject<[Product]>(value: [])
  
  private let remoteRepository: ProductRemoteRepository
  private let localRepository: ProductLocalRepository

  init(
    remoteRepository: ProductRemoteRepository = ProductRemoteRepository(),
    localRepository: ProductLocalRepository = ProductLocalRepository()
  ) {
      self.remoteRepository = remoteRepository
      self.localRepository = localRepository
  }
  
  func fetch() {
    handle(localRepository.load())
    handle(remoteRepository.load())
  }
  
  private func handle(_ items: ObservableProductData?) {
    items?.subscribe(onNext: { products in
        self.products.onNext(products)
      })
      .disposed(by: disposeBag)
  }
}
