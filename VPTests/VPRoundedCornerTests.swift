//
//  RoundedCornerTests.swift
//  VPTests
//
//  Created by Demir Kovacevic on 03/01/2020.
//  Copyright © 2020 Demir Kovacevic. All rights reserved.
//

import XCTest
import SwiftUI

@testable import VP
class RoundedCornerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRoundedCorner() {
        let roundedCorner =  RoundedCorner(radius: 6, corners: UIRectCorner([.bottomLeft, .bottomRight]))
    
        let path = roundedCorner.path(in: CGRect.zero)
        
        XCTAssertFalse(path.isEmpty)
    }
    
    func testCornerRadius() {
        let emptyView = EmptyView()
        
        let roundedView = emptyView.cornerRadius(7, corners: [.bottomLeft, .bottomRight])
        
        XCTAssertNotNil(roundedView)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
