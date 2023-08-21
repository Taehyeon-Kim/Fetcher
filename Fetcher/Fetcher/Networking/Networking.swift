//
//  Networking.swift
//  Fetcher
//
//  Created by taekki on 2023/08/19.
//

import Moya

protocol NetworkingType {
  associatedtype T: TargetType
  var provider: MoyaProvider<T> { get }
}
