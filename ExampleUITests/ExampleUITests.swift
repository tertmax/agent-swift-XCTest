//
//  ExampleUITests.swift
//  ExampleUITests
//
//  Created by Stas Kirichok on 28-08-2018.
//  Copyright © 2018 Sergey Komarov. All rights reserved.
//

import XCTest

class ExampleUITests: XCTestCase {
  
  private let app = XCUIApplication()
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testOnePlusOneIsTwo() {
      let firstField = app.textFields.element(boundBy: 0)
      let secondField = app.textFields.element(boundBy: 1)
      firstField.tap()
      app.keys["1"].tap()
      app.keys["3"].tap()
      
      secondField.tap()
      app.keys["2"].tap()
      app.keys["9"].tap()
      
      let resultField = app.textFields.element(boundBy: 2)
      XCTAssertTrue(resultField.exists, "Text field doesn't exist")
      XCTAssertEqual(resultField.value as! String, "42", "Text field value is not correct")
    }
    
}
