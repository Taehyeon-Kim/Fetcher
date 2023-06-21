//
//  Fetcher.swift
//  Fetcher
//
//  Created by taekki on 2023/06/20.
//

import Foundation
import RxSwift

/**
  - 원격 저장소(Remote Storage)와 로컬 저장소(Local Storage)에서 데이터를 가져오는 객체
 */
final class Fetcher<T> {
  var onRemote: (() -> Single<T>)
  var onLocal: (() -> T)
  
  let disposeBag = DisposeBag()
  
  init(
    onRemote: @escaping () -> Single<T>,
    onLocal: @escaping () -> T
  ) {
    self.onRemote = onRemote
    self.onLocal = onLocal
  }
  
  func fetch() async throws -> [(Status, T)] {
    var results: [(Status, T)] = []
    
    results.append((.loading, await withCheckedContinuation { continuation in
      continuation.resume(returning: self.onLocal())
    }))
    
    do {
      let item = try await self.onRemote().value
      results.append((.success, item))
      
      // 1. 로컬 스토리지 저장
      // 2. 로컬 스토리지 바인딩
      
    } catch {
      results.append((.error, self.onLocal()))
    }
    
    return results
  }
}
