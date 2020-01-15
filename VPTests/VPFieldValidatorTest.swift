//
//  VPFieldValidatorTest.swift
//  VPTests
//
//  Created by Demir Kovacevic on 03/01/2020.
//  Copyright © 2020 Demir Kovacevic. All rights reserved.
//

import XCTest
import SwiftUI

@testable import VP
class VPFieldValidatorTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFieldChecker() {
        let fieldEmptyChecker = FieldChecker()
        let fieldChecker = FieldChecker(errorMessage: "Wrong message")
        
        XCTAssertNil(fieldEmptyChecker.errorMessage)
        XCTAssertTrue(fieldEmptyChecker.valid)
        
        XCTAssertNotNil(fieldChecker.errorMessage)
        XCTAssertEqual(fieldChecker.errorMessage, "Wrong message")
        XCTAssertFalse(fieldChecker.valid)
    }
    
    func testFieldValidator() {
        let fieldEmptyChecker = FieldChecker()
        let fieldValidator = FieldValidator(.constant("Test"), checker: .constant(fieldEmptyChecker), validator: { _ in return nil })
        
        fieldValidator.doValidate()
        
        XCTAssertTrue(fieldEmptyChecker.valid)
        XCTAssertTrue(fieldValidator.isValid)
        XCTAssertTrue(fieldValidator.errorMessage == nil)
    }
        
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
