//
//  AppBackground.swift
//  MovieFlick
//
//  Created by Alex  on 18/8/24.
//

import SwiftUI

struct AppBackground: ViewModifier {
    var gradientOpacity: Double = 0.7
    func body(content: Content) -> some View {
        content
            .background {
                ZStack {
                    Color.black
                    LinearGradient(
                        gradient: Gradient(colors: [Color.purple.opacity(gradientOpacity), Color.gray.opacity(gradientOpacity)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                }
                .ignoresSafeArea()
            }
    }
}
