//
//  ViewExtension.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 27.10.2025.
//

import SwiftUI

extension View {
    @ViewBuilder
    func buttonStyle(state condition: Bool,
                     filled filledStyle: some ButtonStyle,
                     stroke strokeStyle: some ButtonStyle) -> some View {
        if condition {
            self.buttonStyle(filledStyle)
        } else {
            self.buttonStyle(strokeStyle)
        }
    }
    
    func dynamicButtonStyle(isFavorite: Bool) -> some View {
        modifier(DynamicButtonStyle(isFavorite: isFavorite))
    }
}
