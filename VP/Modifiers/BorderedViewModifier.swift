//
//  BorderedViewModifier.swift
//  VP
//
//  Created by Demir Kovacevic on 06/01/2020.
//  Copyright © 2020 Demir Kovacevic. All rights reserved.
//

import SwiftUI

struct BorderedViewModifier: ViewModifier {
    func body(content: Content) -> some View {
      content
        .border(ColorHelper.lightBlue.color(), width: 1)
        .cornerRadius(3, corners: .allCorners)
    }
}

extension View {
  func bordered() -> some View {
    ModifiedContent(content: self, modifier: BorderedViewModifier())
  }
}
