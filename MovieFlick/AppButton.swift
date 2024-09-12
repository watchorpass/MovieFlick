//
//  ButtonComponent.swift
//  MovieFlick
//
//  Created by Fran Malo on 13/8/24.
//

import SwiftUI

struct AppButton: View {
    var title: String
    var color: Color = .yellow
    var animation: Animation? = .spring
    var isButtonDisabled: Bool = false
    var action: () -> Void
    
    @State private var isPressed: Bool = false
    
    var body: some View {
        Button {
            withAnimation(animation) {
                action()
            }
        } label: {
            Text(title)
                .fontWeight(.bold)
                .foregroundColor(.primary.opacity(isButtonDisabled ? 0.4 : 1))
                .padding()
                .frame(maxWidth: 250, maxHeight: 50)
                .background((isPressed || isButtonDisabled) ? color.opacity(0.4) : color.opacity(0.75))
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 4)
                        .fill(isButtonDisabled ? color.opacity(0.5) : color)
                }
                .scaleEffect(isPressed ? 0.95 : 1.0)
        }
        .disabled(isButtonDisabled)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    withAnimation(.easeInOut(duration: 0.1)) {
                        if !isButtonDisabled {
                            isPressed = true
                        }
                    }
                }
                .onEnded { _ in
                    withAnimation(.easeInOut(duration: 0.1)) {
                        if !isButtonDisabled {
                            isPressed = false
                        }
                    }
                }
        )
        .scaleEffect(isPressed ? 0.95 : 1.0)
    }
}
#Preview {
    VStack {
        AppButton(title: "Active Button") {
            print("Popular button tapped")
        }
        AppButton(title: "Button dissabled", color: .red, animation: nil, isButtonDisabled: true) {}
    }
}
