//
//  TabSwitchView.swift
//  VP
//
//  Created by Demir Kovacevic on 30/12/2019.
//  Copyright © 2019 Demir Kovacevic. All rights reserved.
//

import SwiftUI

enum BtnTabSwitchState {
    case register
    case login
}

final internal class TabSwitchStateObservedObject: ObservableObject {
    @Published
    var tabSwitchState: BtnTabSwitchState
    
    init(state: BtnTabSwitchState) {
        self.tabSwitchState = state
    }
}

struct TabSwitchView: View {
    
    @ObservedObject var btnState: TabSwitchStateObservedObject
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.btnState.tabSwitchState = .register
                }) {
                    Text("action_sign_up")
                        .font (
                            .custom (
                                "ClanPro-Medium",
                                size: btnState.tabSwitchState == .login ? 22 : 24
                            )
                    )
                        .foregroundColor (
                            btnState.tabSwitchState == .login
                                ? ColorHelper.textLightGray.color() : Color.white
                    )
                }
                Button(action: {
                    self.btnState.tabSwitchState = .login
                }) {
                    Text("action_sign_in")
                        .font (
                            .custom (
                                "ClanPro-Medium",
                                size: btnState.tabSwitchState == .login ? 24 : 22
                            )
                    )
                        .foregroundColor (
                            btnState.tabSwitchState == .login
                                ? Color.white : ColorHelper.textLightGray.color()
                    )
                }
                Spacer()
            }
            .padding(7)
            .padding(.leading, 20)
        }
        .padding(.top, 50)
    }
}
