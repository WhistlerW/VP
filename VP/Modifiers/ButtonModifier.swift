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
    var corners: UIRectCorner
    var radius: CGFloat = 7
    var height: CGFloat = 35
    
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: height)
            .background(ColorHelper.lightBlue.color())
            .cornerRadius(radius, corners: corners)
            .opacity(!isValid ? 0.4 : 1.0)
            .disabled(!isValid)
            .padding([.leading, .trailing], 20)
    }
    
}

extension View {
    
    func customizeNexButton(
        _ isValid: Binding<Bool>,
        corners: UIRectCorner = [.bottomLeft, .bottomRight],
        radius: CGFloat = 7,
        height: CGFloat = 35
    ) -> some View {
        ModifiedContent(
            content: self,
            modifier: ButtonModifier(
                isValid: isValid,
                corners: corners,
                radius: radius,
                height: height
            )
        )
    }
    
}
