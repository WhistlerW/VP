//
//  LoginView.swift
//  VP
//
//  Created by Demir Kovacevic on 02/12/2019.
//  Copyright © 2019 Demir Kovacevic. All rights reserved.
//

import SwiftUI
import AuthenticationServices

class LoginDataItem: ObservableObject, PNetworkManagerRequestParser {
    @Published var email: String = ""
    @Published var password: String = ""
    
    var headers: HTTPHeaders? {
        return [
            "Authorization": "Basic \(Constants.Authorization.basicAuthorization)"
        ]
    }
    
    var params: Parameters? {
        return [
            "grant_type": "password",
            "username": email,
            "password": password
        ]
    }
    
    var isParameterEncoded: Bool {
        return true
    }
}

struct LoginResponse: Codable {
    var access_token: String
    var token_type: String
    var refresh_token: String
    var expires_in: UInt64
    var user_id: String
    var two_fa_enabled: Bool
 }

struct LoginView: View {
    
    @ObservedObject var item: LoginDataItem = LoginDataItem()
    @ObservedObject var loginRegistrationState: RegistrationLoginStateObservedObject
    
    @State private var emailValid = FieldChecker()
    @State private var passwordValid = FieldChecker()
    
    @State private var showingMessage = false
    @State private var error = ErrorMessage()
    
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
                NetworkManager().request(
                    url: Constants.API.login,
                    inputData: self.item.self ,
                    method: .post, success: { (model: LoginResponse?) in
                        if let model = model {
                            DispatchQueue.main.async {
                                print(model)
                            }
                        }
                }, error: { error in
                    if let err = error {
                        self.error = err
                        self.showingMessage = true
                    }
                })
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
        .alert(isPresented: self.$showingMessage) { () -> Alert in
            Alert(
                title: Text(LocalizedStringKey(stringLiteral: error.title)),
                message: Text(LocalizedStringKey(stringLiteral: error.message)),
                dismissButton: .default(Text(LocalizedStringKey(stringLiteral: "lbl_ok")))
            )
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
