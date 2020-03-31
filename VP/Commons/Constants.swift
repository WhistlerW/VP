//
//  Constants.swift
//  VP
//
//  Created by Demir Kovacevic on 28/11/2019.
//  Copyright © 2019 Demir Kovacevic. All rights reserved.
//

import UIKit
import Foundation

struct Constants {
    struct Validation {
        public static let EmailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z0-9.-]{2,64}"
        public static let PasswordRegex = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+.!=*_])(?=\\S+$).{8,32}$"
        public static let EmptyRegex = "^$"
    }
    
    struct API {
        public static let baseURL = "https://api.mojskrbnik.com"
        public static let termsAndCondition = "http://www.mojskrbnik.com/terms-and-conditions"
        public static let privacyPolicy = "http://www.mojskrbnik.com/privacypolicy"
        public static let login = baseURL + "/user-service/oauth/token?platform=mobile"
    }
    
    struct Authorization {
        public static let basicAuthorization = "TVJXZWJDbGllbnRJZDpYWTdrbXpvTnpsMTAw"
    }

}
