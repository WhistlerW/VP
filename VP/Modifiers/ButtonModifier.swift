//
//  ButtonModifier.swift
//  VP
//
//  Created by Demir Kovacevic on 30/12/2019.
//  Copyright © 2019 Demir Kovacevic. All rights reserved.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    
    @Binding var isValid: Bool

    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0,maxWidth: .infinity, maxHeight: 35)
            .background(ColorHelper.lightBlue.color())
            .cornerRadius(7, corners: [.bottomLeft, .bottomRight])
            .opacity(!isValid ? 0.4 : 1.0)
            .disabled(!isValid)
            .padding([.leading, .trailing], 20)
    }
    
}

extension View {

    func customizeNexButton(_ isValid: Binding<Bool>) -> some View {
        ModifiedContent(
            content: self,
            modifier: ButtonModifier(isValid: isValid)
        )
    }
    
}
