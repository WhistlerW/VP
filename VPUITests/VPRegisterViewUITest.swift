//
//  VPRegisterViewTest.swift
//  VPUITests
//
//  Created by Demir Kovacevic on 03/01/2020.
//  Copyright © 2020 Demir Kovacevic. All rights reserved.
//

import XCTest

class VPRegisterViewTest: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPickerBtnExist() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["loginDisplay"].tap()
        app.buttons["Register"].tap()
        
        let pickerBtn = app.buttons["pickerActionDisplay"]
                
        XCTAssertTrue(pickerBtn.exists)
    }
    
    func testFloatingLableFirstName() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["loginDisplay"].tap()
        app.buttons["Register"].tap()
        
        XCTAssertFalse(app.staticTexts["floatingLabelDisplay"].exists)
        
        let firstNameTxt = app.textFields["First name"]
        
        firstNameTxt.tap()
        firstNameTxt.typeText("test")
        
        
        XCTAssertTrue(app.staticTexts["floatingLabelDisplay"].exists)
    }
    
    func testFloatingLableLastName() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["loginDisplay"].tap()
        app.buttons["Register"].tap()
        
        XCTAssertFalse(app.staticTexts["floatingLabelDisplay"].exists)
        
        let lastNameTxt = app.textFields["Last name"]
        
        lastNameTxt.tap()
        lastNameTxt.typeText("test")
        
        
        XCTAssertTrue(app.staticTexts["floatingLabelDisplay"].exists)
    }
    
    func testFloatingLableEmail() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["loginDisplay"].tap()
        app.buttons["Register"].tap()
        
        XCTAssertFalse(app.staticTexts["floatingLabelDisplay"].exists)
        
        let emailTxt = app.textFields["Email"]
        
        emailTxt.tap()
        emailTxt.typeText("test")
        
        XCTAssertTrue(app.staticTexts["floatingLabelDisplay"].exists)
    }
    
    func testFloatingLableCountry() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["loginDisplay"].tap()
        app.buttons["Register"].tap()
        
        XCTAssertFalse(app.staticTexts["floatingLabelDisplay"].exists)
        
        let countryTxt = app.textFields["Country of residence"]
        
        app/*@START_MENU_TOKEN@*/.buttons["pickerActionDisplay"]/*[[".buttons[\"triangle\"]",".buttons[\"pickerActionDisplay\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables.staticTexts["Albania"].tap()
        
        let floatingLabel = app.staticTexts["floatingLabelDisplay"]
        let countryT = app.textFields["Albania"]
        
        XCTAssertTrue(floatingLabel.exists)
        XCTAssertTrue(countryT.exists)
        XCTAssertFalse(countryTxt.isEnabled)
    }
    
    func testFloatingLablePassword() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["loginDisplay"].tap()
        app.buttons["Register"].tap()
        
        XCTAssertFalse(app.staticTexts["floatingLabelDisplay"].exists)
        
        let passTxt = app.secureTextFields["Password"]
        
        passTxt.tap()
        passTxt.typeText("test")
        
        XCTAssertTrue(app.staticTexts["floatingLabelDisplay"].exists)
    }
}

