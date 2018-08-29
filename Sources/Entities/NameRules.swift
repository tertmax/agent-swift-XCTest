//
//  NameRules.swift
//  ReportPortalAgent
//
//  Created by Stas Kirichok on 29-08-2018.
//  Copyright © 2018 Sergey Komarov. All rights reserved.
//

import Foundation

struct NameRules: OptionSet {
  let rawValue: Int
  
  static let stripTestPrefix = NameRules(rawValue: 1 << 0)
  static let whiteSpaceOnUnderscore = NameRules(rawValue: 1 << 1)
  static let whiteSpaceOnCamelCase = NameRules(rawValue: 1 << 2)
}
