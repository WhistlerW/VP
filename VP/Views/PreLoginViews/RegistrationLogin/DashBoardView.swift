//
//  DashBoardView.swift
//  VP
//
//  Created by Demir Kovacevic on 06/02/2020.
//  Copyright © 2020 Demir Kovacevic. All rights reserved.
//

import SwiftUI

struct DashBoardView: View {
    
    @ObservedObject var loginRegistrationState: RegistrationLoginStateObservedObject
    @State var isButtonEnabled = true
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 0) {
                VStack( alignment: .leading, spacing: 40) {
                    Text("registration_sign_up_success")
                        .multilineTextAlignment(.leading)
                        .font(.custom("ClanPro-Medium", size: 19))
                        .padding(.top, 100)
                    
                    Text("registration_check_email")
                        .multilineTextAlignment(.leading)
                        .font(.custom("ClanPro-Book", size: 17))
                }
                .padding([.leading, .trailing], 44)
                .padding(.bottom, 100)
                
                Button(action: {})
                {
                    Text("registration_go_to_login")
                        .font(.custom("ClanPro-Medium", size: 17))
                        .foregroundColor(Color.white)
                }
                .customizeNexButton($isButtonEnabled,
                                    corners: [.bottomLeft, .bottomRight, .topRight],
                                    radius: 12,
                                    height: 50
                )
                .padding(.bottom, 10)
                .padding(.leading, 24)
            }
            .background(Color.white)
            .cornerRadius(12, corners: [.topRight, .bottomRight])
            .padding(.top, 100)
            
            Image("envelope")
                .resizable()
                .frame(width: 87, height: 99)
                .padding(.top, -160)
                .padding(.leading, 33)
        }
    }
}

#if DEBUG
struct DashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        DashBoardView(loginRegistrationState: RegistrationLoginStateObservedObject(state: .dashboard))
    }
}
#endif
