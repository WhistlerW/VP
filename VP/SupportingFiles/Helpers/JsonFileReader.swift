//
//  JsonFileReader.swift
//  VP
//
//  Created by Demir Kovacevic on 14/01/2020.
//  Copyright © 2020 Demir Kovacevic. All rights reserved.
//

import Foundation

public enum JsonFileName: String {
    case jsonData = "countries"
    case noFile = "noFile"
}

public class JsonFileReader<Value: Codable> {

    public enum Errors: Error {
        case fileNotFound
    }

    public enum Source {
        case jsonFile(_: String, _: Bundle)

        internal func data() throws -> Data {
            switch self {
            case .jsonFile(let fileName, let bundle):
                guard let path = bundle.path(forResource: fileName, ofType: "json") else {
                    throw Errors.fileNotFound
                }
                return try Data(contentsOf: URL(fileURLWithPath: path))
            }
        }
    }

    public let data: Value

    public init(_ file: JsonFileReader.Source = .jsonFile(JsonFileName.jsonData.rawValue, Bundle.main)) throws {
        let rawData = try file.data()
        let decoder = JSONDecoder()
        self.data = try decoder.decode(Value.self, from: rawData)
    }
}
