//
//  GetCurrentLaunchEndPoint.swift
//  Alamofire
//
//  Created by Stas Kirichok on 27-08-2018.
//

import Foundation

struct GetCurrentLaunchEndPoint: EndPoint {
  
  let encoding: ParameterEncoding = .json
  let relativePath: String = "launch"
  let parameters: [String : Any]
    let method: HTTPMethod = .post
  
  init() {
    parameters = [
        "name": "ios",
        "description": "My first launch on RP",
        "startTime": TimeHelper.currentTimeAsString(),
        "mode": "DEFAULT"
    ]
  }
}
