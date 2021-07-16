//
//  VPLoginViewTests.swift
//  VPTests
//
//  Created by Demir Kovacevic on 18/02/2020.
//  Copyright © 2020 Demir Kovacevic. All rights reserved.
//

import XCTest
import ViewInspector
import SwiftUI

@testable import VP

extension LoginView: Inspectable { }

class VPLoginViewTests: XCTestCase {

    var httpClient: NetworkManager!
    var session: MockURLSession!
    
    override func setUp() {
        super.setUp()
        session = MockURLSession()
        httpClient = NetworkManager(session: session)
       
    }
    
    override func tearDown() {
        httpClient = nil
        session = nil
        super.tearDown()
    }

    func testLoginServiceSuccess() {
        let expectedData = ResponseData.expectedResponse.data(using: .utf8)
        let sut = LoginView(loginRegistrationState: RegistrationLoginStateObservedObject(state: .login), networkManager: httpClient)
            .environmentObject(RootViewsType())
  
        session.nextData = expectedData
        
        let button = try? sut.inspect().vStack().button(1)
        try? button?.tap()
        
        
        // XCTAssert(sut.loginResponse?.user_id == "2a46a8e8-72da-4869-a843-dce95839faf9")
        
        
        
        
        //        let exp = sut.inspection.inspect { view in
        //            let button = try view.hStack().button(0)
        //            XCTAssertNotNil(button)
        //            exp.fulfill()
        //        }
        session.nextData = expectedData
        
    }
    
    func testLoginServiceError() {
        let rootView = RootViewsType()
        rootView.typeRootView = .registrationLogin
        rootView.tabState = .login
        let sut = LoginView(loginRegistrationState: RegistrationLoginStateObservedObject(state: .login), networkManager: httpClient)
        
        session.statusCode = 400
        session.nextError = ErrorSimple(domain: "test", code: 10041)
        
        let button = try? sut.inspect().vStack().button(1)
        try? button?.tap()
        
        
        print(sut.error)
        print(sut.showingMessage)
    }
    
}

struct ResponseData {
    static var expectedResponse = """
        {
            "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOlsiTVJXZWJBUElSZXNvdXJjZUlkIl0sInVzZXJfaWQiOiIyYTQ2YThlOC03MmRhLTQ4NjktYTg0My1kY2U5NTgzOWZhZjkiLCJ1c2VyX25hbWUiOiJtczFAY2xpZW50LmNvbSIsInNjb3BlIjpbInJlYWQiLCJ3cml0ZSJdLCJleHAiOjE1ODIxOTY3NTQsInR3b19mYV9lbmFibGVkIjpmYWxzZSwiYXV0aG9yaXRpZXMiOlsiUk9MRV9DTElFTlQiXSwianRpIjoiYmNlN2NhNjMtZjZkMS00NzA4LWIyYjItNDBkMTZkMzE3YTQ0IiwiY2xpZW50X2lkIjoiTVJXZWJDbGllbnRJZCJ9.vJmy8WRiHw-3YNb6Ck7tlbYDLchMRlcIjBsSWmWDIa8",
            "token_type": "bearer",
            "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOlsiTVJXZWJBUElSZXNvdXJjZUlkIl0sInVzZXJfaWQiOiIyYTQ2YThlOC03MmRhLTQ4NjktYTg0My1kY2U5NTgzOWZhZjkiLCJ1c2VyX25hbWUiOiJtczFAY2xpZW50LmNvbSIsInNjb3BlIjpbInJlYWQiLCJ3cml0ZSJdLCJhdGkiOiJiY2U3Y2E2My1mNmQxLTQ3MDgtYjJiMi00MGQxNmQzMTdhNDQiLCJ0d29fZmFfZW5hYmxlZCI6ZmFsc2UsImF1dGhvcml0aWVzIjpbIlJPTEVfQ0xJRU5UIl0sImp0aSI6IjY0YjUyNzYwLTBlMzctNGQwYy04YjRmLWIzYmIyNWIwNGQ1NSIsImNsaWVudF9pZCI6Ik1SV2ViQ2xpZW50SWQifQ.2xLUu-IQ_uyOmBMbE-47XayEc5TN9YdGURNdM2bjQOg",
            "expires_in": 86399,
            "user_id": "2a46a8e8-72da-4869-a843-dce95839faf9",
            "two_fa_enabled": false
        }
    """
}

struct MockLoginRequestData: PNetworkManagerRequestParser {
    var headers: HTTPHeaders? {
          return [
              "Authorization": "Basic \(Constants.Authorization.basicAuthorization)"
          ]
      }

      var params: Parameters? {
          return [
              "grant_type": "password",
              "username": "nn@client.com",
              "password": "User123!!"
          ]
      }

      var isParameterEncoded: Bool {
          return true
      }
}

