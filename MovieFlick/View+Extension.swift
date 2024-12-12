//
//  View+Extension.swift
//  MovieFlick
//
//  Created by Alberto Alegre Bravo on 15/8/24.
//

import SwiftUI

extension View {
    func swipeGestureModifier(offset: Binding<CGSize>, color: Binding<Color>, buttonOpacity: Binding<Bool>) -> some View {
        self.modifier(SwipeGestureModifier(offset: offset, color: color, buttonOpacity: buttonOpacity))
    }
    
    func posterImgModifiers(color: Color) -> some View {
        self.modifier(PosterImgModifiers(color: color))
    }
    
    func appBackground(gradientOpacity: Double = 0.9) -> some View {
        self.modifier(AppBackground(gradientOpacity: gradientOpacity))
    }
}
