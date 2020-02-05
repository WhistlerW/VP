//
//  VPCheckBoxUITests.swift
//  VPUITests
//
//  Created by Demir Kovacevic on 07/01/2020.
//  Copyright © 2020 Demir Kovacevic. All rights reserved.
//

import XCTest
import SwiftUI

class VPCheckBoxUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    override func tearDown() {
      
    }

    func testCheckBoxExist() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["loginDisplay"].tap()
        app.buttons["Register"].tap()
        
        let checkFirstBtn = app.buttons.element(boundBy: 0)
        let checkSecondBtn = app.buttons.element(boundBy: 1)
  
        XCTAssertTrue(checkFirstBtn.exists)
        XCTAssertTrue(checkSecondBtn.exists)
    }
    
    func testCheckBoxTap() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["loginDisplay"].tap()
        app.buttons["Register"].tap()
        
        let firstNameTxt = app.textFields["First name"]
        firstNameTxt.tap()
        firstNameTxt.typeText("Niko")
        
        let lastNameTxt = app.textFields["Last name"]
        lastNameTxt.tap()
        lastNameTxt.typeText("Nikic")

        app/*@START_MENU_TOKEN@*/.buttons["pickerActionDisplay"]/*[[".buttons[\"triangle\"]",".buttons[\"pickerActionDisplay\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables.staticTexts["Albania"].tap()
        
        let emailTxt = app.textFields["Email"]
        emailTxt.tap()
        emailTxt.typeText("nikonikic@live.com")
        
        let password = app.secureTextFields["Password"]
        password.tap()
        password.typeText("User123!!")
        
        let checkFirstBtn = app.buttons.element(boundBy: 0)
        let checkSecondBtn = app.buttons.element(boundBy: 1)
        
        checkFirstBtn.tap()
        checkSecondBtn.tap()
        
        let btnNext = app.buttons["NEXT"]
        
        XCTAssertFalse(btnNext.isEnabled)
    }
    
    func testCheckImageExist() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["loginDisplay"].tap()
        app.buttons["Register"].tap()
        
        let checkImg = app.buttons["checkBtnDisplay"]
        XCTAssertTrue(checkImg.exists)
    }
    
    func testCheckBtnExist() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["loginDisplay"].tap()
        app.buttons["Register"].tap()
        
        let checkBtn = app.buttons["checkBtnDisplay"]
        
        XCTAssertTrue(checkBtn.exists)
    }
    
    func testCheckBtnTap() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["loginDisplay"].tap()
        app.buttons["Register"].tap()
        
        let checkBtn = app.buttons["checkBtnDisplay"]
        checkBtn.firstMatch.tap()
        
        XCTAssertTrue(checkBtn.firstMatch.exists)
    }
    
    //checkLabelDisplay
    func testLabelExist() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["loginDisplay"].tap()
        app.buttons["Register"].tap()
        
        let firstLabel = app.buttons["checkLabelDisplay"].firstMatch
        
        XCTAssertTrue(firstLabel.exists)
    }
    
    func testLableMatch() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["loginDisplay"].tap()
        app.buttons["Register"].tap()
        
        let firstLabel = app.buttons["checkLabelDisplay"].firstMatch.label
        
        XCTAssertEqual(firstLabel, "I accept the Terms and conditions")
    }
    
    func testTapOnLabelCheckBox() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["loginDisplay"].tap()
        app.buttons["Register"].tap()
        
        let firstTextBtn = app.buttons["checkLabelDisplay"].firstMatch
        
        XCTAssertTrue(firstTextBtn.exists)
    }


}
