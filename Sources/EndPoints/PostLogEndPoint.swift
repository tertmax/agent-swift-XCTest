//
//  PostLogEndPoint.swift
//  RPAgentSwiftXCTest
//
//  Created by Stas Kirichok on 23-08-2018.
//  Copyright © 2018. All rights reserved.
//

import Foundation

struct PostLogEndPoint: EndPoint {
    
    let method: HTTPMethod = .post
    let relativePath: String = "log"
    let parameters: [String : Any]
    var headers: [String : String] {
        if uploadData != nil {
            return ["Content-Type": "multipart/form-data; boundary=\(boundary)"]
        } else {
            return [:]
        }
    }
    var uploadData: Data?
    private let boundary = UUID().uuidString
    
    init(itemID: String, launchUuid: String, level: String, message: String, data: Data?) {
        
        if let imageData = data {
            var formData = Data()
            let jsonString = "[{\"file\":{\"name\":\"test-screenshot.png\"},\"itemId\":\"\(itemID)\",\"launchUuid\":\"\(launchUuid)\",\"level\":\"\(level)\",\"message\":\"\(message.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\"", with: #"\""#))\",\"time\":\"\(TimeHelper.currentTimeAsString())\"}]"
            
            formData.append(contentsOf: "\r\n--\(boundary)\r\n".data(using: .utf8)!)
            formData.append(contentsOf: "Content-Disposition:form-data; name=\"json_request_part\"; filename=\"test-json-part.json\"\r\n".data(using: .utf8)!)
            formData.append(contentsOf: "Content-Type: application/json\r\n\r\n\(jsonString)\r\n".data(using: .utf8)!)
            formData.append(contentsOf: "\r\n--\(boundary)\r\n".data(using: .utf8)!)
            formData.append(contentsOf: "Content-Disposition: form-data; name=\"file\"; filename=\"test-screenshot.png\"\r\n".data(using: .utf8)!)
            formData.append(contentsOf: "Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            formData.append(contentsOf: imageData)
            formData.append(contentsOf: "\r\n".data(using: .utf8)!)
            formData.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

            self.uploadData = formData
            self.parameters = [:]
        } else {
            parameters = [
                "item_id": itemID,
                "level": level,
                "message": message,
                "time": TimeHelper.currentTimeAsString()
            ]
        }
    }
}
