//
//  Product.swift
//  Fetcher
//
//  Created by taekki on 2023/08/19.
//

import Foundation

struct ProductResponse: Codable {
  let products: [Product]
  let total: Int
  let limit: Int
}

struct Product: Codable {
  let id: Int
  let title: String
  let description: String
  let price: Int
  let brand: String
}
