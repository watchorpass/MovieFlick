//
//  CustomAlertView.swift
//  MovieFlick
//
//  Created by Fran on 17/01/2025.
//

import SwiftUI

struct CustomAlertView: View {
    let errorTitle: String
    let errorMessage: String
    let retryAction: () -> Void
    
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 70))
                .foregroundColor(.white)
                .rotationEffect(.degrees(isAnimating ? 10 : -10))
                .animation(
                    Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: true),
                    value: isAnimating
                )
                .onAppear {
                    isAnimating = true
                }
                Text(errorTitle)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text(errorMessage)
                .font(.body)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            AppButton(icon: Image(systemName: "arrow.clockwise"), title: "Play again") {
                retryAction()
            }
        }
        .padding()
        .background(.ultraThinMaterial.opacity(0.4))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
                .fill(.white)
                .shadow(radius: 2)
        }
        .padding()
        .foregroundStyle(Color.white)
    }
}

#Preview {
    CustomAlertView(errorTitle: "TEST error title", errorMessage: "this is a message. lorem ipsum dolor sit amet", retryAction: {})
        .appBackground()
}
