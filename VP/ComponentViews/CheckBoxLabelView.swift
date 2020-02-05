//
//  CheckBoxLabelView.swift
//  VP
//
//  Created by Demir Kovacevic on 07/01/2020.
//  Copyright © 2020 Demir Kovacevic. All rights reserved.
//

import SwiftUI

struct CheckBoxLabelView: View {
    
    @Binding var isChecked: Bool
    
    var titlLbl: String
    var hyperLinksTitle: String = ""
    var hyperLink: URL?
    
    var body: some View {
        HStack(spacing: 15) {
            CheckBox(isChecked: $isChecked)
                .frame(width:17.5, height: 17.5)
    
            Button(action: {
                if let url = self.hyperLink {
                    UIApplication.shared.open(url)
                }
            }) {
                Text(LocalizedStringKey(stringLiteral: titlLbl))
                    .font(.system(size: 11))
                    .foregroundColor(Color.black)
                +
                Text(LocalizedStringKey(stringLiteral: hyperLinksTitle))
                        .font(.system(size: 11))
                        .foregroundColor(Color.blue)
            }.accessibility(identifier: "checkLabelDisplay")
        }
        .customCheckBoxFrame()
    }
}

#if DEBUG
struct CheckBoxLabelView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxLabelView(isChecked: .constant(false),
                          titlLbl: "registration_privacy_policy")
    }
}
#endif
