//
//  DefaultButtonFormatting.swift
//  HugeDatabase
//
//  Created by Pierre on 16/12/2022.
//

import SwiftUI

struct DefaultButtonViewModifier: ViewModifier {
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        return content
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(10)
            .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0.0, y: 10)
    }
}

extension View {
    func withDefaultButtonFormatting(backgroundColor: Color = .blue) -> some View {
        modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor))
    }
}
