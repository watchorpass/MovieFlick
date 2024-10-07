//
//  AppBackground.swift
//  MovieFlick
//
//  Created by Alex  on 18/8/24.
//

import SwiftUI

struct AppBackground: ViewModifier {
    var gradientOpacity: Double = 0.8
    func body(content: Content) -> some View {
        content
            .background {
                ZStack {
                    Color.white
                    Image(.portada)
                        .opacity(0.7)
                    LinearGradient(
                        gradient: Gradient(colors: [Color.purple.opacity(gradientOpacity), Color.black.opacity(0.9)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                }
            }
    }
}
