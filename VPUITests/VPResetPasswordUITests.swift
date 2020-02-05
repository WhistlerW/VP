//
//  VPResetPasswordUITests.swift
//  VPUITests
//
//  Created by Demir Kovacevic on 05/02/2020.
//  Copyright © 2020 Demir Kovacevic. All rights reserved.
//

import XCTest

class VPResetPasswordUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    override func tearDown() {

    }

    func testFloatingLabelEmail() {
         let app = XCUIApplication()
         app.launch()
         app.buttons["LOG IN"].tap()
         app.buttons["Forgot password?"].tap()
         
         XCTAssertFalse(app.staticTexts["floatingLabelDisplay"].exists)
         
         let emailTxt = app.textFields["Email"]
         
         emailTxt.tap()
         emailTxt.typeText("test")
         
         
         XCTAssertTrue(app.staticTexts["floatingLabelDisplay"].exists)
     }
    
    func testEmailFailValidation() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["LOG IN"].tap()
        app.buttons["Forgot password?"].tap()
        
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
          app.buttons["Forgot password?"].tap()
          
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
        app.buttons["Forgot password?"].tap()
        
        let emailTxt = app.textFields["Email"]
        
        emailTxt.tap()
        emailTxt.typeText("test@test.com")
        
        let btnNext = app.buttons["RESET MY PASSWORD"]
        
        XCTAssertTrue(btnNext.isEnabled)
    }
    
    
    func testTapNextBtn() {
           let app = XCUIApplication()
           app.launch()
           
           app.buttons["LOG IN"].tap()
           app.buttons["Forgot password?"].tap()
           
           let emailTxt = app.textFields["Email"]
           
           emailTxt.tap()
           emailTxt.typeText("test@test.com")
        
           let btnNext = app.buttons["RESET MY PASSWORD"]
           
           btnNext.tap()
       }
}
