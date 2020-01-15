//
//  Constants.swift
//  VP
//
//  Created by Demir Kovacevic on 28/11/2019.
//  Copyright © 2019 Demir Kovacevic. All rights reserved.
//

import UIKit

struct Constants {
    struct Validation {
        public static let EmailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z0-9.-]{2,64}"
        public static let PasswordRegex = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+.!=*_])(?=\\S+$).{8,32}$"
        public static let EmptyRegex = "^$"
    }
}
