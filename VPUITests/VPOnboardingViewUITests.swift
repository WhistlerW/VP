//
//  VPOnboardingViewUITests.swift
//  VPUITests
//
//  Created by Demir Kovacevic on 05/02/2020.
//  Copyright © 2020 Demir Kovacevic. All rights reserved.
//

import XCTest

class VPOnboardingViewUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
        
    }

    func testSwipeOnboarding() {
        let app = XCUIApplication()
        app.launch()
        
        let findOutMore = app.buttons["findOutMoreDisplay"]
        findOutMore.tap()
        
        XCTAssertTrue(app.staticTexts["Welcome to a whole new way to manage your money. Gain a holistic view of your financial life."].exists)
        app.images["first"].swipeLeft()
        XCTAssertTrue(app.staticTexts["Our tools make it easier to manage and grow your money."].exists)
    }

}
