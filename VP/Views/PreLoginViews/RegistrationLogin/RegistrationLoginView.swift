//
//  RegistrationLoginView.swift
//  VP
//
//  Created by Demir Kovacevic on 03/12/2019.
//  Copyright © 2019 Demir Kovacevic. All rights reserved.
//

import SwiftUI

struct RegistrationLoginView: View {
    
    @ObservedObject var btnState: TabSwitchStateObservedObject
    
    @ObservedObject var loginData = LoginDataItem()
    @ObservedObject var registerData = RegisterDataItem()
    
    @State var isFormValid: Bool = false
    
    var body: some View {
        VStack(spacing: 25) {
            TabSwitchView(btnState: btnState)
            
            VStack {
                if btnState.tabSwitchState == .register {
                    RegisterView(item: registerData)
                } else if btnState.tabSwitchState == .login {
                    LoginView(item: loginData)
                }
            }
            .padding(.trailing, 20)
            
           
            
            Spacer()
        }.background(ColorHelper.darkBlue.color())
    }
}


#if DEBUG
struct RegistrationLoginView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationLoginView(btnState: .init(state: .login))
    }
}
#endif
