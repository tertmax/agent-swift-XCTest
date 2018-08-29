//
//  ExampleTests.swift
//  ExampleTests
//
//  Created by Stas Kirichok on 28-08-2018.
//  Copyright © 2018 Windmill Smart Solutions. All rights reserved.
//

import XCTest
@testable import Example

class SummatorTests: XCTestCase {
  
  private let summator = SummatorService()
  
  func testSumOfTwoZerosIsZero() {
    let result = summator.addNumbers(first: 0, second: 0)
    XCTAssertEqual(result, 0)
  }
  
  func testSumOfTwoRandomNumberIsCorrect() {
    let first = Int(arc4random_uniform(42))
    let second = Int(arc4random_uniform(42))
    let result = summator.addNumbers(first: first, second: second)
    XCTAssertEqual(result, first + second)
  }
  
}
