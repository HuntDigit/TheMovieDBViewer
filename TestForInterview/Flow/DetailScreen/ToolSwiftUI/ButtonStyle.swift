//
//  ButtonStyle.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 27.10.2025.
//

import SwiftUI

struct DynamicButtonStyle: ViewModifier {
    var isFavorite: Bool

    func body(content: Content) -> some View {
        content
            .buttonStyle(state: isFavorite,
                         filled: LargeMoviewButtonStyleFilled(),
                         stroke: LargeMoviewButtonStyleStroke())
    }
}

struct LargeMoviewButtonStyleFilled: ButtonStyle {
    
    @Environment(\.colorScheme) var colorScheme
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16))
            .frame(maxWidth: .infinity)
            .padding(14)
            .foregroundColor(Color.btnTxt1)
            .background(Color.btnBg1)
            .clipShape(Capsule())
            .opacity(configuration.isPressed ? 0.7 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct LargeMoviewButtonStyleStroke: ButtonStyle {
    
    @Environment(\.colorScheme) var colorScheme
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16))
            .frame(maxWidth: .infinity)
            .padding(14)
            .foregroundColor(colorScheme == .light ? .btnTxt1 : .btnTxt2)
            .background(backgroundView())
            .opacity(configuration.isPressed ? 0.7 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
    
    func backgroundView() -> some View {
        ZStack {
            Capsule()
                .stroke(lineWidth: 1)
                .foregroundColor(colorScheme == .light ? Color.btnTxt1 : Color.btnTxt2)
        }
    }
}
