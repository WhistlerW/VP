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
    case homeView
}

final internal class RootViewsType: ObservableObject {
    @Published
    var typeRootView: TypeRootView = .launchview
    var tabState: RegistrationLoginState = .login
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
                RegistrationLoginView(
                    loginRegistrationState: .init(state: rootViewType.tabState)
                )
                .edgesIgnoringSafeArea(.all)
            } else if rootViewType.typeRootView == .homeView {
                let dataModel = ChartDataModel(dataModel: sample)
                HomeView(dataModel: dataModel)
            }
        }
    }
}
