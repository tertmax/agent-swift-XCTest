//
//  RPServices.swift
//  com.oxagile.automation.RPAgentSwiftXCTest
//
//  Created by Sergey Komarov on 6/26/17.
//  Copyright © 2017 Oxagile. All rights reserved.
//

import Foundation
import XCTest

enum ReportingServiceError: Error {
  case launchIdNotFound
  case testSuiteIdNotFound
}

class ReportingService {
  
  private let httpClient: HTTPClient
  private let configuration: AgentConfiguration
  
  private var launchID: String?
  private var testSuiteStatus = TestStatus.passed
  private var launchStatus = TestStatus.passed
  private var testSuiteID: String?
  private var testID = ""
  
  private let semaphore = DispatchSemaphore(value: 0)
  private let timeOutForRequestExpectation = 10.0
  
  init(configuration: AgentConfiguration) {
    self.configuration = configuration
    httpClient = HTTPClient(baseURL: configuration.reportPortalURL)
    httpClient.setPlugins([AuthorizationPlugin(token: configuration.portalToken)])
  }

  func startLaunch() throws {
    let endPoint = StartLaunchEndPoint(launchName: configuration.launchName, tags: configuration.tags)
    
    try httpClient.callEndPoint(endPoint) { (result: Launch) in
      self.launchID = result.id
      self.semaphore.signal()
    }
    _ = semaphore.wait(timeout: .now() + timeOutForRequestExpectation)
  }
  
  func startTestSuite(_ suite: XCTestSuite) throws {
    guard let launchID = launchID else {
      throw ReportingServiceError.launchIdNotFound
    }
    
    let endPoint = StartItemEndPoint(itemName: suite.name, launchID: launchID, type: .suite)
    try httpClient.callEndPoint(endPoint) { (result: Item) in
      self.testSuiteID = result.id
      self.semaphore.signal()
    }
    _ = semaphore.wait(timeout: .now() + timeOutForRequestExpectation)
  }
  
  func startTest(_ test: XCTestCase) throws {
    guard let launchID = launchID else {
      throw ReportingServiceError.launchIdNotFound
    }
    guard let testSuiteID = testSuiteID else {
      throw ReportingServiceError.testSuiteIdNotFound
    }
    let endPoint = StartItemEndPoint(itemName: test.name, parentID: testSuiteID, launchID: launchID, type: .test)
    
    try httpClient.callEndPoint(endPoint) { (result: Item) in
      self.testID = result.id
      self.semaphore.signal()
    }
    _ = semaphore.wait(timeout: .now() + timeOutForRequestExpectation)
  }
  
  func reportError(message: String) throws {
    let endPoint = PostLogEndPoint(itemID: testID, level: "error", message: message)
    try httpClient.callEndPoint(endPoint) { (result: Item) in
      self.semaphore.signal()
    }
    _ = semaphore.wait(timeout: .now() + timeOutForRequestExpectation)
  }
  
  func finishTest(_ test: XCTestCase) throws {
    let testStatus = test.testRun!.hasSucceeded ? TestStatus.passed : TestStatus.failed
    if testStatus == .failed {
      testSuiteStatus = .failed
      launchStatus = .failed
    }
    
    let endPoint = FinishItemEndPoint(itemID: testID, status: testStatus)
    
    try httpClient.callEndPoint(endPoint) { (result: Finish) in
      self.semaphore.signal()
    }
    _ = semaphore.wait(timeout: .now() + timeOutForRequestExpectation)
  }
  
  func finishTestSuite() throws {
    guard let testSuiteID = testSuiteID else {
      throw ReportingServiceError.testSuiteIdNotFound
    }
    let endPoint = FinishItemEndPoint(itemID: testSuiteID, status: testSuiteStatus)
    try httpClient.callEndPoint(endPoint) { (result: Finish) in
      self.semaphore.signal()
    }
    _ = semaphore.wait(timeout: .now() + timeOutForRequestExpectation)
  }
  
  func finishLaunch() throws {
    let endPoint = FinishLaunchEndPoint(launchID: launchID!, status: launchStatus)
    try httpClient.callEndPoint(endPoint) { (result: Finish) in
      self.semaphore.signal()
    }
    _ = semaphore.wait(timeout: .now() + timeOutForRequestExpectation)
  }
}
