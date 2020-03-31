//
//  MockURLSession.swift
//  VP
//
//  Created by Demir Kovacevic on 19/02/2020.
//  Copyright © 2020 Demir Kovacevic. All rights reserved.
//

import Foundation

extension Decodable {
    static func decode(from json: String) -> Self? {
        guard let data = json.data(using: .utf8) else {
            return nil
        }

        return try? JSONDecoder().decode(self, from: data)
    }
}

extension Encodable {
    var json: String? {
        guard let data = data else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    var data: Data? {
        try? JSONEncoder().encode(self)
    }
}

//MARK: MOCK
public protocol Taggable {
    static var tag: String { get }
}

public extension Taggable {
    static var tag: String {
        String(describing: self)
    }
}

struct ErrorSimple: Codable {
    var domain: String = ""
    var code: Int = 1
}

class MockURLSession: Codable, Taggable {
    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: ErrorSimple?
    var statusCode: Int? = 200
    var emptyURLResponse: Bool = false
    private (set) var lastURL: URL?
}

extension MockURLSession: URLSessionProtocol {
    func  successHttpURLResponse(request: URLRequest) -> URLResponse? {
        return emptyURLResponse ?  nil : HTTPURLResponse(url: request.url!, statusCode: statusCode!, httpVersion: "HTTP/1.1", headerFields: nil)
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        var error: Error? = nil
        if let next = nextError {
            error = NSError(domain: next.domain, code: next.code, userInfo: nil)
        }
        completionHandler(nextData, successHttpURLResponse(request: request), error)
        return nextDataTask
    }
}

class MockURLSessionDataTask: Codable, URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}
