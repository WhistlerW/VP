//
//  ColorHelperTest.swift
//  VPTests
//
//  Created by Demir Kovacevic on 28/11/2019.
//  Copyright © 2019 Demir Kovacevic. All rights reserved.
//

import XCTest
import SwiftUI

@testable import VP
class VPColorHelperTest: XCTestCase {

    override func setUp() {
       super.setUp()
    }

    override func tearDown() {
       super.tearDown()
    }

    func testColor() {
        let color = ColorHelper.darkBlue.color()
        let color1 = ColorHelper.color(from: "dbColor1")
        let color2 = ColorHelper.color(from: "noColor")
        
        XCTAssertEqual(color2, Color.yellow)
        XCTAssertEqual(color, color1)
    }

}
