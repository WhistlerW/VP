//
//  TabSwitchView.swift
//  VP
//
//  Created by Demir Kovacevic on 30/12/2019.
//  Copyright © 2019 Demir Kovacevic. All rights reserved.
//

import SwiftUI

struct TabSwitchView: View {
    
    @ObservedObject var btnState: RegistrationLoginStateObservedObject
    
    var body: some View {
        VStack {
            HStack {
                if btnState.state != .dashboard {
                    Button(action: {
                        self.btnState.state = .register
                    }) {
                        Text("action_sign_up")
                            .font (
                                .custom (
                                    "ClanPro-Medium",
                                    size: btnState.state == .login || btnState.state == .resetPassword ? 22 : 24
                                )
                        )
                            .foregroundColor (
                                btnState.state == .login || btnState.state == .resetPassword
                                    ? ColorHelper.textLightGray.color() : Color.white
                        )
                    }
                    Button(action: {
                        self.btnState.state = .login
                    }) {
                        Text("action_sign_in")
                            .font (
                                .custom (
                                    "ClanPro-Medium",
                                    size: btnState.state == .login || btnState.state == .resetPassword  ? 24 : 22
                                )
                        )
                            .foregroundColor (
                                btnState.state == .login || btnState.state == .resetPassword
                                    ? Color.white : ColorHelper.textLightGray.color()
                        )
                    }
                }
                Spacer()
            }
            .padding(7)
            .padding(.leading, 20)
        }
        .padding(.top, 50)
    }
}
