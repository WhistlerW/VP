//
//  VPRegistrationLoginViewUITests.swift
//  VPUITests
//
//  Created by Demir Kovacevic on 30/12/2019.
//  Copyright © 2019 Demir Kovacevic. All rights reserved.
//

import XCTest

class VPRegistrationLoginViewUITests: XCTestCase {
    
    override func setUp() {
        continueAfterFailure = false
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTabSwitchView() {
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["LOG IN"].tap()
        
        let btnRegister = app.buttons["Register"]
        btnRegister.tap()
        
        XCTAssertFalse(app.buttons["Forgot password?"].exists)
        
        let btnLogin  = app.buttons["Log in"]
        btnLogin.tap()
        
        XCTAssertTrue(app.buttons["Forgot password?"].exists)
        
        let btnForgotPassword = app.buttons["Forgot password?"]
        btnForgotPassword.tap()
        
        XCTAssertFalse(app.buttons["Forgot password?"].exists)
    }
    
    func testForgotBtnTap() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["LOG IN"].tap()
        
        let forgotPass = app.buttons["Forgot password?"]
        forgotPass.tap()
        
        XCTAssertTrue(app.staticTexts["Please enter your email address so we can reset your password."].exists)
    }
    
    func testGoogleBtnTap() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["LOG IN"].tap()
        
        let btnFacebook = app.buttons["facebookBtn"]
    }
    
    func testFacebookBtnTap() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["LOG IN"].tap()
        
        let btnGoogle = app.buttons["googleBtn"]
    }
    
}
