//
//  ProductRepository.swift
//  Fetcher
//
//  Created by taekki on 2023/08/21.
//

import RxSwift

typealias ObservableProductData = Observable<[Product]>

protocol RepositoryProtocol {
  associatedtype T
  
  func save(_ item: T)
  func load() -> T?
}

class Repository<T>: RepositoryProtocol {
  
  let repository: Repository?
  
  init(repository: Repository? = nil) {
    self.repository = repository
  }
  
  func save(_ item: T) {
    fatalError("concrete classes should implement this method")
  }
  
  func load() -> T? {
    fatalError("concrete classes should implement this method")
  }
}

final class ProductRemoteRepository: Repository<ObservableProductData> {
  private let networking = ProductNetworking()
  private let localRepository: Repository = ProductLocalRepository()
  
  override func save(_ item: ObservableProductData) {
    // save on local
  }
  
  @discardableResult
  override func load() -> ObservableProductData? {
    let remoteData = networking.request().map(\.products)
    if let localRepo = localRepository as? ProductLocalRepository {
      localRepo.save(remoteData)
    }
    return remoteData
  }
}

final class ProductLocalRepository: Repository<ObservableProductData> {
  private let localDataSource = ProductLocalDataSource()
  
  override func save(_ item: ObservableProductData) {
    localDataSource.saveProducts(item)
  }
  
  @discardableResult
  override func load() -> ObservableProductData? {
    return localDataSource.fetchProducts()
  }
}
