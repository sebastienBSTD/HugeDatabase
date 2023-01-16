//
//  ButtonPressableStyle.swift
//  HugeDatabase
//
//  Created by Pierre on 16/12/2022.
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    let scaleAmount: CGFloat
    
    init(scaleAmount: CGFloat = 0.9) {
        self.scaleAmount = scaleAmount
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleAmount : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
    }
}

extension View {
    func withPressableStyle(scaleAmount: CGFloat = 0.9) -> some View {
        buttonStyle(PressableButtonStyle(scaleAmount: scaleAmount))
    }
}


