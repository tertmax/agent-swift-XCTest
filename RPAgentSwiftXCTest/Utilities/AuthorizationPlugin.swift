//
//  EndPointBuilder.swift
//  RPAgentSwiftXCTest
//
//  Created by Stas Kirichok on 23-08-2018.
//  Copyright © 2018 Sergey Komarov. All rights reserved.
//

import Foundation

class AuthorizationPlugin: HTTPClientPlugin {

  private let token: String
  private lazy var defaultHeader: [String: String] = {
    return [
      "Content-Type": "application/json",
      "Authorization": "Bearer \(token)",
    ]
  }()
  
  init(token: String) {
    self.token = token
  }
  
  func processRequest(_ originRequest: inout URLRequest) {
    if originRequest.allHTTPHeaderFields == nil {
      originRequest.allHTTPHeaderFields = [:]
    }
    originRequest.allHTTPHeaderFields! += defaultHeader
  }
  
}

extension Dictionary {
  public static func +=(lhs: inout [Key: Value], rhs: [Key: Value]) { rhs.forEach({ lhs[$0] = $1}) }
}

