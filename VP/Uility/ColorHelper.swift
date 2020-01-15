//
//  ColorHelper.swift
//  DigitalBank
//
//  Created by Ada Hadžikasimović on 10/8/18.
//  Copyright © 2018 ABC Software Development. All rights reserved.
//

import SwiftUI

enum ColorHelper: String {
    case darkBlue = "dbColor1"
    case textLightGray = "dbColor2"
    case lightBlue = "dbColor3"
    
    func color() -> Color {
        return Color(self.rawValue)
    }
    
    static func color(from string: String) -> Color {
        if let c = self.init(rawValue: string) {
            return c.color()
        }
        
        return Color.yellow
    }
    
}
