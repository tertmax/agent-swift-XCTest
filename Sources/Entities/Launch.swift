//
//  Launch.swift
//  RPAgentSwiftXCTest
//
//  Created by Stas Kirichok on 23-08-2018.
//  Copyright © 2018. All rights reserved.
//

import Foundation

struct Launch: Decodable {
  let id: String
  let number: Int
  let status: String?
}

struct LaunchList: Decodable {
    let uuid: String
    let number: Int
    let status: String?
}

struct LaunchListInfo: Decodable {
  let content: [LaunchList]
}
