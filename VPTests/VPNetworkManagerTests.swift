//
//  VPNetworkManagerTests.swift
//  VPTests
//
//  Created by Demir Kovacevic on 11/02/2020.
//  Copyright © 2020 Demir Kovacevic. All rights reserved.
//

import XCTest
import Foundation

@testable import VP
struct Results: Codable {
    var name: String
}

class VPNetworkManagerTests: XCTestCase {
    
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
    
    func testRequestWithUrl() {
        let error = ErrorMessage(title: "lbl_error", message: "lbl_error")
        var errorResponse: ErrorMessage?
        
        httpClient.request(url: "@%#%@", inputData: nil, method: .get,
                           success: { (model: Results?) in}) { (error) in
                            errorResponse = error
        }
        
        XCTAssert(error.title == errorResponse?.title)
        XCTAssert(error.message == errorResponse?.message)
    }
    
    func testAPIErrorBadFormat() {
        var errorResponse: ErrorMessage?
        let expectedData = "{ codes: 10041 }".data(using: .utf8)
        
        session.statusCode = (404)
        session.nextData = expectedData
        
        httpClient.request(url: "test", inputData: nil, method: .get,
                           success: { (model: Results?) in}) { (error) in
                            errorResponse = error
        }
        
        XCTAssert("lbl_error" == errorResponse?.title)
        XCTAssert("The data couldn’t be read because it isn’t in the correct format." == errorResponse?.message)
    }
    
    func testAPIErrorNotFound() {
        let error = ErrorHandler.apiError(10041).message
        var errorResponse: ErrorMessage?
        let expectedData = """
        {
            "code": 10041,
            "message": "demir"
        }
        """.data(using: .utf8)
        
        session.statusCode = (404)
        session.nextData = expectedData
        
        httpClient.request(url: "test", inputData: nil, method: .get,
                           success: { (model: Results?) in}) { (error) in
                            errorResponse = error
        }
        
        XCTAssert(error.title == errorResponse?.title)
        XCTAssert(error.message == errorResponse?.message)
    }
    
    func testAPIErrorCodeNullNotFound() {
        var errorResponse: ErrorMessage?
        let expectedData = """
        {
            "code": null ,
            "message": "demir"
        }
        """.data(using: .utf8)
        
        session.statusCode = (404)
        session.nextData = expectedData
        
        httpClient.request(url: "test", inputData: nil, method: .get,
                           success: { (model: Results?) in}) { (error) in
                            errorResponse = error
        }
        
        XCTAssert("lbl_error" == errorResponse?.title)
        XCTAssert("lbl_error" == errorResponse?.message)
    }
    
    func testAPICorrectResponse() {
        var response: Results?
        let expectedData = """
           {
               "name": "demir",
           }
           """.data(using: .utf8)
        
        session.nextData = expectedData
        
        httpClient.request(url: "test", inputData: nil, method: .get,
                           success: { (model: Results?) in
                            response = model
        }) { (error) in
            
        }
        
        XCTAssert(response?.name == "demir")
    }
    
    func testAPIResponeBadDecode() {
        var response: Results?
        var errorResponse: ErrorMessage?
        let expectedData = """
           {
               "names": "demir",
           }
           """.data(using: .utf8)
        
        session.nextData = expectedData
        
        httpClient.request(url: "test", inputData: nil, method: .get,
                           success: { (model: Results?) in
                            response = model
        }) { (error) in
            errorResponse = error
        }
        
        XCTAssert(response == nil)
        XCTAssert(errorResponse?.title == "lbl_error")
        XCTAssert(errorResponse?.message == "The data couldn’t be read because it is missing.")
    }
    
    func testAPIEmptyResponse() {
        var response: Results?
        var errorResponse: ErrorMessage?
        
        session.emptyURLResponse = true

        httpClient.request(url: "test", inputData: nil, method: .get,
                           success: { (model: Results?) in
                            response = model
        }) { (error) in
            errorResponse = error
        }
        
        XCTAssert(response == nil)
        XCTAssert(errorResponse?.title == "lbl_error")
        XCTAssert(errorResponse?.message == "lbl_error")
    }
    
    func testAPISomeErrorURLResponse() {
        var response: Results?
        var errorResponse: ErrorMessage?
       
        session.nextError = ErrorSimple(domain: "TestError", code: 11)
        
        httpClient.request(url: "test", inputData: nil, method: .get,
                           success: { (model: Results?) in
                            response = model
        }) { (error) in
            errorResponse = error
        }
        
        XCTAssert(response == nil)
        XCTAssert(errorResponse?.title == "lbl_error")
        XCTAssert(errorResponse?.message == "The operation couldn’t be completed. (TestError error 11.)")
    }
    
    func testRequestMockedEncodedBody() {
        var response: Results?
        let expectedData = """
            {
                "name": "demir",
            }
            """.data(using: .utf8)
        
        session.nextData = expectedData
        
        struct MockRequestData: PNetworkManagerRequestParser {
            var mockName: String = "mojeime"

            var headers: HTTPHeaders? {
                return [
                    "Authorization": "Basic test"
                ]
            }
            var params: Parameters? {
                return [
                    "mockName": mockName,
                ]
            }
            var isParameterEncoded: Bool {
                return true
            }
        }
        
        
        httpClient.request(url: "test", inputData: MockRequestData(), method: .post,
                           success: { (model: Results?) in
                           response = model
        }) { (error) in }
        
        XCTAssert(response!.name == "demir")
    }
    
    func testRequestMockedBody() {
        var response: Results?
        let expectedData = """
            {
                "name": "demir",
            }
            """.data(using: .utf8)
        
        session.nextData = expectedData
        
        struct MockRequestData: PNetworkManagerRequestParser {
            var mockName: String = "mojeime"

            var headers: HTTPHeaders? {
                return [
                    "Authorization": "Basic test"
                ]
            }
            var params: Parameters? {
                return [
                    "mockName": mockName,
                ]
            }
            var isParameterEncoded: Bool {
                return false
            }
        }
        
        
        httpClient.request(url: "test", inputData: MockRequestData(), method: .post,
                           success: { (model: Results?) in
                           response = model
        }) { (error) in }
        
        XCTAssert(response!.name == "demir")
    }
    
    func testGetResumeCalled() {
        
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        
        httpClient.request(url: "test", inputData: nil, method: .get,
                           success: { (model: Results?) in}) { (error) in }
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
}

