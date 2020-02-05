//
//  ResetPasswordView.swift
//  VP
//
//  Created by Demir Kovacevic on 05/02/2020.
//  Copyright © 2020 Demir Kovacevic. All rights reserved.
//

import SwiftUI

class ResetPasswordItem: ObservableObject {
    @Published var email: String = ""
}


struct ResetPasswordView: View {
    
    @ObservedObject var item: ResetPasswordItem = ResetPasswordItem()
    
    @State var emailValid = FieldChecker()
    
    var body: some View {
        let validation = Binding(
            get: { return self.emailValid.valid },
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
            }
            .background(Color.white)
            .cornerRadius(7, corners: [.topRight, .bottomRight])
            
            Button(action: {
                
            }) {
                Text("login_forgot_password_reset_password")
                    .font(.custom("ClanPro-Medium", size: 14))
                    .foregroundColor(Color.white)
            }
            .customizeNexButton(validation)
            
            
            Text("login_forgot_password_text")
                .font(.custom("ClanPro-Medium", size: 14))
                .multilineTextAlignment(.center)
                .foregroundColor(Color.white)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.top, 200)
        }
    }
}
#if DEBUG
struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
#endif
