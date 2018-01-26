//
//  Pagination.swift
//
//  Created by hintoz on 05.03.17
//  Copyright (c) Evgeny Dats. All rights reserved.
//

import Foundation
import ObjectMapper

public class Pagination: Mappable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let total = "total"
    static let current = "current"
    static let totalItems = "total_items"
    static let perpage = "perpage"
  }

  // MARK: Properties
  public var total: Int?
  public var current: Int?
  public var totalItems: String?
  public var perpage: Int?

  // MARK: ObjectMapper Initializers
  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public required init?(map: Map) {

  }

  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public func mapping(map: Map) {
    total <- map[SerializationKeys.total]
    current <- map[SerializationKeys.current]
    totalItems <- map[SerializationKeys.totalItems]
    perpage <- map[SerializationKeys.perpage]
  }
}
