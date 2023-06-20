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

  func fetch() -> Observable<(Status, T)> {
    return Observable.create { observer in
      observer.onNext((.loading, self.onLocal()))
      
      self.onRemote().subscribe { item in
        observer.onNext((.success, item))
        
        // 1. 로컬 스토리지 저장
        // 2. 로컬 스토리지 바인딩
        
      } onFailure: { error in
        observer.onNext((.error, self.onLocal()))
      }
      .disposed(by: self.disposeBag)

      return Disposables.create()
    }
  }
}
