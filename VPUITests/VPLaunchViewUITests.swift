//
//  VPUITests.swift
//  VPUITests
//
//  Created by Demir Kovacevic on 28/11/2019.
//  Copyright © 2019 Demir Kovacevic. All rights reserved.
//

import XCTest
import SwiftUI

class VPUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    override func tearDown() {
       
    }
    
    func testAllAssetInLaunchDisplay() {
        let app = XCUIApplication()
        app.launch()
        
        let logoDisplay = app.images["logoDisplay"]
        let loginDisplay = app.buttons["loginDisplay"]
        let findOutMoreDisplay = app.buttons["findOutMoreDisplay"]
        
        XCTAssert(logoDisplay.label == "mrLogo")
        XCTAssert(loginDisplay.label == "LOG IN")
        XCTAssert(findOutMoreDisplay.label == "Find out more")
        
    }

    func testPressLoginButton() {
        let app = XCUIApplication()
        app.launch()
        
        let loginButton = app.buttons["LOG IN"]
        loginButton.tap()
        
        let button = app.buttons["Register"]
        XCTAssertTrue(button.exists)
    
    }
    
    func testPressFindOutMore() {
        let app = XCUIApplication()
        app.launch()
        
        let findOutMore = app.buttons["findOutMoreDisplay"]
        findOutMore.tap()
                
        let findOutMoreDisplay = app.staticTexts["Welcome to a whole new way to manage your money. Gain a holistic view of your financial life."]
        
        XCTAssertTrue(findOutMoreDisplay.exists)
    }

}
