//
//  VPJsonFileReaderUITests.swift
//  VPUITests
//
//  Created by Demir Kovacevic on 14/01/2020.
//  Copyright © 2020 Demir Kovacevic. All rights reserved.
//

import XCTest

class VPPickerListViewUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testChekElementExist() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["loginDisplay"].tap()
        app.buttons["Register"].tap()
        
        app/*@START_MENU_TOKEN@*/.buttons["pickerActionDisplay"]/*[[".buttons[\"triangle\"]",".buttons[\"pickerActionDisplay\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let table = app.tables.element(boundBy: 0)
        let cell = table.cells.element(boundBy: 20)
        
        app.tables.element.scrollToElement(element: cell)
        
        let biH = app.staticTexts["Bosnia and Herzegovina"]
        
        XCTAssertTrue(biH.exists)
    }
}

extension XCUIElement {

    func scrollToElement(element: XCUIElement) {
        while !element.visible() {
            swipeUp()
        }
    }

    func visible() -> Bool {
        guard self.exists && !self.frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }

}
