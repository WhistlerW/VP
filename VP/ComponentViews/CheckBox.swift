//
//  CheckBox.swift
//  VP
//
//  Created by Demir Kovacevic on 06/01/2020.
//  Copyright © 2020 Demir Kovacevic. All rights reserved.
//

import SwiftUI

struct CheckBox: View {
    
    @Binding var isChecked: Bool
    
    var body: some View {
        Button(action: {
            self.isChecked = !self.isChecked
        }) {
            Image("check")
                .resizable()
                .foregroundColor (
                    Color.white
            )
                .accessibility(identifier: "checkImageDisplay")
        }
        .background (
            !isChecked ? Color.white : ColorHelper.lightBlue.color()
        )
            .bordered()
            .accessibility(identifier: "checkBtnDisplay")
    }
}

#if DEBUG
struct CheckBox_Previews: PreviewProvider {
    static var previews: some View {
        CheckBox(isChecked: .constant(false))
            .previewLayout(.fixed(width: 400, height: 400))
    }
}
#endif
