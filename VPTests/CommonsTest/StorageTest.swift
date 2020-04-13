//
//  StorageTest.swift
//  VPTests
//
//  Created by Demir Kovacevic on 03/04/2020.
//  Copyright © 2020 Demir Kovacevic. All rights reserved.
//

import XCTest
@testable import VP

class CustomMockData: Codable {
    var test: String = "test"
}

class StorageTest: XCTestCase {
    
    @Storage(key: "defaultValue", defaultValue: false, userDefaults: UserDefaults(suiteName: #file)!)
    var defaultValue
    
    @StorageCustomObject<CustomMockData>(key: "customMockData", defaultValue: nil, userDefaults: UserDefaults(suiteName: #file)!)
    var customObject

    override func setUp() {
        UserDefaults(suiteName: #file)!.removePersistentDomain(forName: #file)
    }

    override func tearDown() {}

    func testDefaultValue() {
        XCTAssertFalse(defaultValue)
    }

    func testSetValue() {
        defaultValue = true
        XCTAssertTrue(defaultValue)
    }
    
    func testNilCustomObject() {
        customObject = nil
        XCTAssertNil(customObject)
    }
    
    func testNotNilValue() {
        customObject = CustomMockData()
        let customTest = customObject?.test
        XCTAssertNotNil(customObject)
        XCTAssertTrue(customTest == "test")
    }
}
