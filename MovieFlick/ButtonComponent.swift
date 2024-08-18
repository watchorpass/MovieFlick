//
//  ButtonComponent.swift
//  MovieFlick
//
//  Created by Fran Malo on 13/8/24.
//

import SwiftUI

struct ButtonComponent: View {
    var title: String
    var action: () -> Void
    var color: Color = .yellow
    
    @State private var isPressed: Bool = false
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding()
                .frame(maxWidth: 250, maxHeight: 50)
                .background(isPressed ? color.opacity(0.4) : color.opacity(0.8))
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 4)
                        .fill(color)
                }
                .scaleEffect(isPressed ? 0.95 : 1.0) // Leve reducción al presionar

        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isPressed = true
                    }
                }
                .onEnded { _ in
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isPressed = false
                    }
                }
        )
    }
}
#Preview {
    ButtonComponent(title: "Popular") {
        print("Popular button tapped")
    }
}
