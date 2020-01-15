//
//  RegistrationView.swift
//  VP
//
//  Created by Demir Kovacevic on 03/12/2019.
//  Copyright © 2019 Demir Kovacevic. All rights reserved.
//

import SwiftUI

class RegisterDataItem: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var country: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
}

struct RegisterView: View {
    @ObservedObject var item: RegisterDataItem
    
    @State var firstNameValid = FieldChecker()
    @State var lastNameValid = FieldChecker()
    @State var countryValid = FieldChecker()
    @State var emailValid = FieldChecker()
    @State var passwordValid = FieldChecker()
    @State var isCheckedTearms = false
    @State var isCheckedPolicy = false
    
    var body: some View {
        
        let validation = Binding(
            get: {
                self.emailValid.valid
                    && self.passwordValid.valid
                    && self.firstNameValid.valid
                    && self.lastNameValid.valid
                    && self.countryValid.valid
                    && self.isCheckedTearms
                    && self.isCheckedPolicy
        },
            set: { print($0) }
        )
        
        return VStack(spacing: 0) {
            VStack(spacing: 0) {
                Group {
                    FloatingLabelTextField (
                        placeholder: "lbl_first_name",
                        value: $item.firstName,
                        checker: $firstNameValid
                    ) { firstName in
                        let isValid = firstName.validate (
                            regex: Constants.Validation.EmptyRegex
                        )
                        return !isValid ? nil : "error"
                    }
                    .customizeFrame()
                    
                    Rectangle()
                        .addLineSpacer()
                    
                    FloatingLabelTextField (
                        placeholder: "lbl_last_name",
                        value: $item.lastName,
                        checker: $lastNameValid
                    ) { lastName in
                        let isValid = lastName.validate (
                            regex: Constants.Validation.EmptyRegex
                        )
                        return !isValid ? nil : "error"
                    }
                    .customizeFrame()
                    
                    Rectangle()
                        .addLineSpacer()
                    
                    FloatingLabelTextField (
                        placeholder: "lbl_country_of_residence",
                        value: $item.country,
                        checker: $countryValid,
                        pickerField: true
                    ) { country in
                        let isValid = country.validate (
                            regex: Constants.Validation.EmptyRegex
                        )
                        return !isValid ? nil : "error"
                    }
                    .customizeFrame()
                    
                    Rectangle()
                        .addLineSpacer()
                    
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
                
                VStack(alignment: .leading, spacing: 0) {
                    Rectangle()
                        .addLineSpacer()
                    
                    CheckBoxLabelView (
                        isChecked: $isCheckedTearms,
                        titlLbl: "registration_privacy_policy"
                    )
                    
                    Rectangle()
                        .addLineSpacer()
                    
                    CheckBoxLabelView (
                        isChecked: $isCheckedPolicy,
                        titlLbl: "registration_privacy_policy"
                    )
                }
            }
            .background(Color.white)
            .cornerRadius(7, corners: [.topRight, .bottomRight])
            
            if validation.wrappedValue {
                Button(action: {
                    
                }) {
                    Text("action_next")
                        .font(.custom("ClanPro-Medium", size: 14))
                        .foregroundColor(Color.white)
                }
                .customizeNexButton(validation)
            }
            
            if !validation.wrappedValue {
                VStack {
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
                }.padding(.top, 30)
            }
        }
    }
}

#if DEBUG
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(item: RegisterDataItem())
    }
}
#endif
