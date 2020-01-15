//
//  LaunchView.swift
//  VP
//
//  Created by Demir Kovacevic on 28/11/2019.
//  Copyright © 2019 Demir Kovacevic. All rights reserved.
//

import SwiftUI

struct LaunchView: View {
    
    @EnvironmentObject private var rootViewType: RootViewsType
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Video(url: Bundle.main.path(forResource: "MR7", ofType: "mp4")!)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Image("mrLogo")
                        .resizable()
                        .frame(
                            width: geometry.size.width / 3,
                            height: geometry.size.width / 3
                    )
                        .position(
                            x: geometry.size.width / 2,
                            y: geometry.size.height / 3
                    )
                        .opacity(0.7)
                        .accessibility(identifier: "logoDisplay")
                    
                    VStack(alignment: .center, spacing: 20 ) {
                        Button(action: {
                            self.rootViewType.typeRootView = .registrationLogin
                        }) {
                            Text("action_sign_in_uppercased")
                                .font(.custom("ClanPro-Medium", size: 17))
                                .foregroundColor(.white)
                                .accessibility(identifier: "loginDisplay")
                            
                        }
                        .padding (
                            EdgeInsets (
                                top: 8,
                                leading: 16,
                                bottom: 8,
                                trailing: 16
                            )
                        )
                            .frame(width: geometry.size.width / 1.25, height: 50)
                            .background(ColorHelper.darkBlue.color())
                            .cornerRadius(7)
                            .opacity(0.7)
                        
                        
                        Button(action: {
                            self.rootViewType.typeRootView = .onboarding
                        }) {
                            Text("lbl_find_out_more")
                                .font(.system(size: 15))
                                .foregroundColor(.white)
                                .accessibility(identifier: "findOutMoreDisplay")
                        }
                        
                       
                    }.padding(.bottom, 20)
                }
            }
        }
    }
}

#if DEBUG
struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
#endif
