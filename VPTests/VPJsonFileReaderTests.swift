//
//  VPJsonFileReaderTests.swift
//  VPTests
//
//  Created by Demir Kovacevic on 14/01/2020.
//  Copyright © 2020 Demir Kovacevic. All rights reserved.
//

import XCTest
import SwiftUI

@testable import VP
class VPJsonFileReaderTests: XCTestCase {

    override func setUp() {

    }

    override func tearDown() {
      
    }

    func testValidParseJson() {
        let countriesJSON: JsonFileReader<CountriesDataModel>? = {
            do {
                return try JsonFileReader<CountriesDataModel>()
            } catch _ {
                return nil
            }
        }()
        
        XCTAssertNoThrow(countriesJSON)
        XCTAssertTrue(countriesJSON?.data.countries.count != 0)
    }
    
    func testNoJSONFile() {
        XCTAssertThrowsError(try JsonFileReader<CountriesDataModel>(.jsonFile(JsonFileName.noFile.rawValue, Bundle.main)))
    }
}
