//
//  UITests.swift
//  SafeBodaChallengeUITests
//
//  Created by Rotem Nevgauker on 01/10/2019.
//  Copyright © 2019 Rotem Nevgauker. All rights reserved.
//

import XCTest

class UITests: XCTestCase {

    
    var app: XCUIApplication!

    override func setUp() {
       
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()

     
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testingTables() {
      
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
