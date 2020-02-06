//
//  RegistrationLoginView.swift
//  VP
//
//  Created by Demir Kovacevic on 03/12/2019.
//  Copyright © 2019 Demir Kovacevic. All rights reserved.
//

import SwiftUI

enum RegistrationLoginState {
    case register
    case login
    case resetPassword
    case dashboard
}

final internal class RegistrationLoginStateObservedObject: ObservableObject {
    @Published
    var state: RegistrationLoginState
    
    init(state: RegistrationLoginState) {
        self.state = state
    }
}

struct RegistrationLoginView: View {
    
    @ObservedObject var loginRegistrationState: RegistrationLoginStateObservedObject
    
    @State var isFormValid: Bool = false
    
    var body: some View {
        VStack(spacing: 25) {
            TabSwitchView(btnState: loginRegistrationState)
            
            VStack {
                if loginRegistrationState.state == .register {
                    RegisterView(loginRegistrationState: loginRegistrationState)
                } else if loginRegistrationState.state == .login {
                    LoginView(loginRegistrationState: loginRegistrationState)
                } else if loginRegistrationState.state == .resetPassword {
                    ResetPasswordView(loginRegistrationState: loginRegistrationState)
                } else if loginRegistrationState.state == .dashboard {
                    DashBoardView(loginRegistrationState: loginRegistrationState)
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
        RegistrationLoginView(loginRegistrationState: .init(state: .login))
    }
}
#endif
