//
//  ViewPreviewsTests.swift
//  UnitTests
//
//  Created by Alexey Naumov on 01.11.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import XCTest
import ViewInspector
@testable import VP

final class ViewPreviewsTests: XCTestCase {

    func testFloatingLabelTextFieldPreviews() {
        _ = FloatingLabelTextField_Previews.previews
    }
    
    func testCheckBoxPreviews() {
        _ = CheckBox_Previews.previews
    }
    
    func testCheckBoxLabelViewPreviews() {
        _ = CheckBoxLabelView_Previews.previews
    }
    
    func testRegistrationLoginView_Previews() {
        _ = RegistrationLoginView_Previews.previews
    }
    
    func testLoginViewPreviews() {
        _ = LoginView_Previews.previews
    }
    
    func testRegisterViewPreviews() {
        _ = RegisterView_Previews.previews
    }
    
    func testResetPasswordViewPreviews() throws {
        _ = ResetPasswordView_Previews.previews
    }
    
    func testDashBoardViewPreviews() {
        _ = DashBoardView_Previews.previews
    }
    
    func testLaunchViewPreviews() {
        _ = LaunchView_Previews.previews
    }
    
    func testOnboardingViewPreviews() {
        _ = OnboardingView_Previews.previews
    }
}
