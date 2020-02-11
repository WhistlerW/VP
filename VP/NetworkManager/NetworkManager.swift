//
//  NetworkManager.swift
//  MyTodoApp
//
//  Created by Ada Hadzikasimovic on 18/12/2019.
//  Copyright © 2019 ABC Software Development. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]
public typealias HTTPHeaders = [String: String]

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

struct ErrorMessage {
    var title: String
    var message: String
    
    init(title: String = "lbl_error", message: String = "") {
        self.title = title
        self.message = message
    }
}

struct ErrorCode: Codable {
    var code: Int?
    var message: String?
}

enum ErrorHandler {
    case noInternet
    case apiError(_ code: Int)
    case unknown(_ error: Error?)
    
    var message: ErrorMessage {
        switch self {
        case .noInternet:
            return ErrorMessage(message: "msgs_no_internet")
        case .apiError(let code):
            return ErrorMessage(message: "error_\(code)")
        case .unknown(let error):
            if let e = error {
                return ErrorMessage(message: e.localizedDescription)
            } else {
                return ErrorMessage(message: "lbl_error")
            }
        }
    }
}

class NetworkManager {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: Request
    func request<T: Codable>(
        url: String,
        inputData: PNetworkManagerRequestParser?,
        method: HTTPMethod,
        success: @escaping (_ data: T?) -> Void,
        error: @escaping (ErrorMessage?) -> Void
    ) {
        
        guard let url = URL(string: url) else {
            error(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let inputData = inputData, let params = inputData.params, method != .get {
            if inputData.isParameterEncoded {
                request.httpBody = NetworkManagerRequestParser.encodeBody(from: params)
            } else {
                request.httpBody = NetworkManagerRequestParser.body(from: params)
            }
        }
        
        if let headers = inputData?.headers {
            request.allHTTPHeaderFields = headers
        }
        
        session.dataTask(with: request) { (data, response, err) in
            if let e = err {
                error(ErrorHandler.unknown(e).message)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                error(ErrorHandler.unknown(nil).message)
                return
            }
            
            if -1009 == response.statusCode {
                error(ErrorHandler.noInternet.message)
            } else if (200...299).contains(response.statusCode) {
                if let data = data {
                    do {
                        if let model = try JSONDecoder().decode(T?.self, from: data) {
                            success(model)
                        }
                    } catch let err {
                        error(ErrorHandler.unknown(err).message)
                    }
                }
            } else {
                if let data = data {
                    do {
                        if let errorCode = try JSONDecoder().decode(ErrorCode?.self, from: data) {
                            if let code = errorCode.code{
                                error(ErrorHandler.apiError(code).message)
                            } else {
                                error(ErrorHandler.unknown(nil).message)
                            }
                        }
                    } catch let err {
                        error(ErrorHandler.unknown(err).message)
                    }
                }
            }
        }.resume()
    }
}

protocol PNetworkManagerRequestParser {
    var params: Parameters? { get }
    var headers: HTTPHeaders? { get }
    var isParameterEncoded: Bool { get }
}

extension PNetworkManagerRequestParser {
    var isParameterEncodeds: Bool {
        return false
    }
}

class NetworkManagerRequestParser {
    
    static func body(from params: Parameters?) -> Data {
        return (try? JSONSerialization.data(withJSONObject: params ?? [:], options: [])) ?? Data()
    }
    
    static func percentEscapeString(_ string: String) -> String {
        return string.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
    
    static func encodeBody(from params: Parameters) -> Data {
        let parameterArray = params.map { (arg) -> String in
            let (key, value) = arg
            return "\(key)=\(self.percentEscapeString(value as? String ?? ""))"
        }
        return parameterArray.joined(separator: "&").data(using: String.Encoding.utf8) ?? Data()
    }
}

