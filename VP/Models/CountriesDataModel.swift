//
//  CountriesDataModel.swift
//  VP
//
//  Created by Demir Kovacevic on 14/01/2020.
//  Copyright © 2020 Demir Kovacevic. All rights reserved.
//

import Foundation

public struct CountriesDataModel: Codable {
    
    public struct Country: Codable, Equatable{
        public let code: String
        public let name: String
        public let dialCode: String
    }
    
    public let countries: [Country]
}
