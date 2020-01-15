//
//  FloatingLabelTextField.swift
//  VP
//
//  Created by Demir Kovacevic on 25/12/2019.
//  Copyright © 2019 Demir Kovacevic. All rights reserved.
//

import SwiftUI

struct FloatingLabelTextField: View {
    
    typealias Validator = (String) -> String?
    var tfPlaceholder: String
    
    var secureField: Bool
    var pickerField: Bool
    
    @ObservedObject var field: FieldValidator<String>
    
    @State var rightImage: Image? = nil
    @State var showPassword: Bool = false
    @State var showPicker: Bool = false
    
    init(
        placeholder: String = "",
        value: Binding<String>,
        checker: Binding<FieldChecker>,
        secureField: Bool = false,
        pickerField: Bool = false,
        validator: @escaping Validator
    ) {
        self.tfPlaceholder = placeholder
        self.secureField = secureField
        self.pickerField = pickerField
        self.field = FieldValidator (
            value,
            checker: checker,
            validator: validator
        )
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 0)
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 0) {
                    if self.field.value.count != 0 {
                        Text(LocalizedStringKey(stringLiteral: tfPlaceholder))
                            .font(.custom("ClanPro-Book", size: 11))
                            .foregroundColor(Color.gray)
                            .accessibility(identifier: "floatingLabelDisplay")
                    }
                    
                    if secureField {
                        if !showPassword {
                            SecureField (
                                LocalizedStringKey(stringLiteral: tfPlaceholder),
                                text: $field.value
                            )
                                .onAppear {
                                    self.field.doValidate()
                            }
                            .autocapitalization(.none)
                        } else {
                            TextField (
                                LocalizedStringKey(stringLiteral: tfPlaceholder),
                                text: $field.value
                            )
                                .autocapitalization(.none)
                        }
                    } else {
                        TextField (
                            LocalizedStringKey(stringLiteral: tfPlaceholder),
                            text: $field.value
                        )
                        .disabled(pickerField)
                        .onAppear {
                                self.field.doValidate()
                        }
                        .autocapitalization(.none)
                    }
                }
                
                if !pickerField {
                    if !secureField {
                        if self.field.value.count != 0 {
                            if (field.isValid) {
                                Image("validCheck")
                                    .resizable()
                                    .frame(width: 15.5, height: 15.5)
                                    .foregroundColor(.secondary)
                            } else {
                                Image("invalidCheck")
                                    .resizable()
                                    .frame(width: 15.5, height: 15.5)
                                    .foregroundColor(.secondary)
                            }
                        }
                    } else {
                        Button(action: {
                            self.showPassword = !self.showPassword
                        }) {
                            Image("passwordScure")
                                .resizable()
                                .frame(width: 20.5, height: 15.5)
                                .foregroundColor(Color.gray)
                                .opacity(showPassword ? 1 : 0.2)
                        }.accessibility(identifier: "showPasswordDisplay")
                    }
                } else {
                    Button(action: {
                        self.showPicker = true
                    }) {
                        Image("triangle")
                            .resizable()
                            .frame(width: 15, height: 9)
                            .foregroundColor(ColorHelper.darkBlue.color())
                    }
                    .sheet(isPresented: $showPicker) {
                        PickerListView(pickedValue:  self.$field.value, showPicker: self.$showPicker)
                    }
                    .accessibility(identifier: "pickerActionDisplay")
                }
            }
        }
    }
}

#if DEBUG
struct FloatingLabelTextField_Previews: PreviewProvider {
    static var previews: some View {
        FloatingLabelTextField(placeholder: "Email",
                               value: .constant(""),
                               checker: .constant(FieldChecker()),
                               secureField: true
        ) { email in
            return nil
        }
    }
}
#endif
