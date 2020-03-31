//
//  VPLoginViewUITests.swift
//  VPUITests
//
//  Created by Demir Kovacevic on 03/01/2020.
//  Copyright © 2020 Demir Kovacevic. All rights reserved.
//

import XCTest

class VPLoginViewUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }
    
    override func tearDown() {
       // httpClient = nil
       // session = nil
        super.tearDown()
    }

    func testFloatingLabelEmail() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["LOG IN"].tap()
        
        XCTAssertFalse(app.staticTexts["floatingLabelDisplay"].exists)
        
        let emailTxt = app.textFields["Email"]
        
        emailTxt.tap()
        emailTxt.typeText("test")
        
        
        XCTAssertTrue(app.staticTexts["floatingLabelDisplay"].exists)
    }
    
    func testFloatingLabelPassword() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["LOG IN"].tap()
        
        XCTAssertFalse(app.staticTexts["floatingLabelDisplay"].exists)
        
        let passswordSTF = app.secureTextFields["Password"]
        
        passswordSTF.tap()
        passswordSTF.typeText("test")
        
        
        XCTAssertTrue(app.staticTexts["floatingLabelDisplay"].exists)
    }
    
    func testEmailFailValidation() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["LOG IN"].tap()
        
        let emailTxt = app.textFields["Email"]
        
        emailTxt.tap()
        emailTxt.typeText("test")
        
        let invalidImage = app.images["invalidCheck"]
        
        XCTAssertTrue(invalidImage.exists)
    }
    
    func testEmailPassValidation() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["LOG IN"].tap()
        
        let emailTxt = app.textFields["Email"]
        
        emailTxt.tap()
        emailTxt.typeText("test@test.com")
        
        let validImage = app.images["validCheck"]
        
        XCTAssertTrue(validImage.exists)
    }
    
    func testNextBtnIsEnabled() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["LOG IN"].tap()
        
        let emailTxt = app.textFields["Email"]
        
        emailTxt.tap()
        emailTxt.typeText("test@test.com")
        
        let passswordSTF = app.secureTextFields["Password"]
        
        passswordSTF.tap()
        passswordSTF.typeText("User123!!")
        
        let btnNext = app.buttons["NEXT"]
        
        XCTAssertTrue(btnNext.isEnabled)
    }
    
    func testShowPassword() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["LOG IN"].tap()
        
        let passSTF = app.secureTextFields["Password"]
        
        XCTAssertTrue(passSTF.exists)
        
        passSTF.tap()
        passSTF.typeText("test")
        
        let btnShowPass = app.buttons["showPasswordDisplay"]
        
        btnShowPass.tap()
        
        let passTxt = app.textFields["Password"]
        
        XCTAssertTrue(passTxt.exists)
    }
    
    func testTapNextBtn() {
        let app = XCUIApplication()
        
        app.launch()
            
        app.buttons["LOG IN"].tap()

        let emailTxt = app.textFields["Email"]

        emailTxt.tap()
        emailTxt.typeText("test@test.com")

        let passswordSTF = app.secureTextFields["Password"]

        passswordSTF.tap()
        passswordSTF.typeText("User123!!")

        let btnNext = app.buttons["NEXT"]
        
        btnNext.tap()
        
    }
}

