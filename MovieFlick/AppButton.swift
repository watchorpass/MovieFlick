//
//  ButtonComponent.swift
//  MovieFlick
//
//  Created by Fran Malo on 13/8/24.
//

import SwiftUI

struct AppButton: View {
    var icon: Image?
    var title: LocalizedStringKey
    var color: Color = .clear
    var animation: Animation? = .spring
    var isButtonDisabled: Bool = false
    var action: () -> ()
    
    @State private var isPressed: Bool = false
    
    var body: some View {
        Button {
            withAnimation(animation) {
                action()
            }
        } label: {
            HStack {
                if let icon {
                    icon
                        .resizable()
                        .scaledToFit()
                }
                Text(title)
            }
            .fontWeight(.bold)
            .foregroundStyle(isButtonDisabled ? .white.opacity(0.5) : .white)
            .foregroundColor(.primary.opacity(isButtonDisabled ? 0.4 : 1))
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(isButtonDisabled ? color.opacity(0.2) : color.opacity(0.6))
            .cornerRadius(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .fill(isButtonDisabled ? .white.opacity(0.5) : .white)
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
        AppButton(title: "Active Button", color: .gray) {
            print("Popular button tapped")
        }
        AppButton(title: "Button dissabled", color: .gray, animation: nil, isButtonDisabled: true) {}
        AppButton(icon: Image(systemName: "arrow.clockwise"),title: "Button enabled", animation: nil, isButtonDisabled: false) {}
        AppButton(icon: Image(systemName: "arrow.clockwise"),title: "Button dissabled", animation: nil, isButtonDisabled: true) {}
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .appBackground(gradientOpacity: 0.5)
}
