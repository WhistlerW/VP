//
//  FloatingTextFieldModifier.swift
//  VP
//
//  Created by Demir Kovacevic on 26/12/2019.
//  Copyright © 2019 Demir Kovacevic. All rights reserved.
//

import SwiftUI

struct FloatingTextFieldModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(height: 45)
            .padding(EdgeInsets (
                top: 5,
                leading: 27,
                bottom: 5,
                trailing: 17
            )
        )
    }
    
}

struct LineSpacerModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(height: 0.3)
            .padding(.leading, 15)
            .foregroundColor(Color.gray.opacity(0.4))
            .opacity(0.8)
    }
    
}

struct CheckBoxModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(height: 45)
            .padding(.top, 5)
            .padding(.bottom, 5)
            .padding(.leading, 27)
            .padding(.trailing, 10)
    }
    
}

extension View {
    
    func customizeFrame() -> some View {
        ModifiedContent(
            content: self,
            modifier: FloatingTextFieldModifier()
        )
    }
    
    func customCheckBoxFrame() -> some View {
        ModifiedContent(
            content: self,
            modifier: CheckBoxModifier()
        )
    }
    
    func addLineSpacer() -> some View {
        ModifiedContent(
            content: self,
            modifier: LineSpacerModifier()
        )
    }
    
}
