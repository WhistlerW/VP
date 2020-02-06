//
//  LoginView.swift
//  VP
//
//  Created by Demir Kovacevic on 02/12/2019.
//  Copyright © 2019 Demir Kovacevic. All rights reserved.
//

import SwiftUI
import AuthenticationServices

class LoginDataItem: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
}

struct LoginView: View {
    
    @ObservedObject var item: LoginDataItem = LoginDataItem()
    @ObservedObject var loginRegistrationState: RegistrationLoginStateObservedObject
    
    @State var emailValid = FieldChecker()
    @State var passwordValid = FieldChecker()
    
    var body: some View {
        
        let validation = Binding(
            get: { return self.emailValid.valid && self.passwordValid.valid },
            set: { print($0)}
        )
        
        return VStack(spacing: 0) {
            VStack(spacing: 0) {
                FloatingLabelTextField (
                    placeholder: "lbl_email", 
                    value: $item.email,
                    checker: $emailValid
                ) { email in
                    let isValid = email.validate (
                        regex: Constants.Validation.EmailRegex
                    )
                    return isValid ? nil : "error"
                }
                .customizeFrame()
                
                Rectangle()
                    .addLineSpacer()
                
                FloatingLabelTextField (
                    placeholder: "lbl_password",
                    value: $item.password,
                    checker: $passwordValid,
                    secureField: true
                ) { password in
                    let isValid = password.validate (
                        regex: Constants.Validation.PasswordRegex
                    )
                    return isValid ? nil : "error"
                }
                .customizeFrame()
                
            }
            .background(Color.white)
            .cornerRadius(7, corners: [.topRight, .bottomRight])
            
            Button(action: {
            
            }) {
                Text("action_next")
                    .font(.custom("ClanPro-Medium", size: 14))
                    .foregroundColor(Color.white)
            }
            .customizeNexButton(validation)
            
            VStack {
                Button(action: {
                    self.loginRegistrationState.state = .resetPassword
                }) {
                    Text("login_forgot_password")
                        .foregroundColor(Color.white)
                }
                
                HStack(spacing: 20) {
                    Button(action: {
                        
                    }) {
                        Image("fbBtn")
                            .resizable()
                            .frame(width: 45.5, height: 45)
                    }
                    .accessibility(identifier: "facebookBtn")
                    
                    Button(action: {
                        
                    }) {
                        Image("googleBtn")
                            .resizable()
                            .frame(width: 45.5, height: 45)
                    }
                    .accessibility(identifier: "googleBtn")
                }
                
            }.padding(.top, 20)
        }
    }
    
}

#if DEBUG
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginRegistrationState: RegistrationLoginStateObservedObject(state: .login))
    }
}
#endif
