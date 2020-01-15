//
//  String+Custom.swift
//  VP
//
//  Created by Demir Kovacevic on 30/12/2019.
//  Copyright © 2019 Demir Kovacevic. All rights reserved.
//

import SwiftUI

extension String {
    func validate(regex: String) -> Bool {
        let textPredictor = NSPredicate (
            format:"SELF MATCHES %@", regex
        )
        return textPredictor.evaluate(with: self)
    }
}
