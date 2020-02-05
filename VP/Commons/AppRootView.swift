//
//  AppRootView.swift
//  VP
//
//  Created by Demir Kovacevic on 02/12/2019.
//  Copyright © 2019 Demir Kovacevic. All rights reserved.
//

import SwiftUI

enum TypeRootView {
    case launchview
    case onboarding
    case registrationLogin
}

final internal class RootViewsType: ObservableObject {
    @Published
    var typeRootView: TypeRootView = .launchview
    var tabState: BtnTabSwitchState = .login
}

struct AppRootView: View {

    @EnvironmentObject private var rootViewType: RootViewsType
    
    var body: some View {
        Group {
            if rootViewType.typeRootView == .launchview {
                LaunchView()
            } else if rootViewType.typeRootView == .onboarding {
                OnboardingView()
            } else if rootViewType.typeRootView == .registrationLogin {
                RegistrationLoginView(btnState: .init(state: rootViewType.tabState))
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}
