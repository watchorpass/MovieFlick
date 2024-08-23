//
//  PlayerTextField.swift
//  MovieFlick
//
//  Created by Alex  on 21/8/24.
//

import SwiftUI

struct PlayerTextField: View {
    var backgroundText: String
    @Binding var text: String
    var color: Color
    
    var body: some View {
        TextField(backgroundText, text: $text)
            .multilineTextAlignment(.center)
            .font(.title)
            .bold()
            .foregroundColor(.primary)
            .padding()
            .frame(maxWidth: 250, maxHeight: 50)
            .background(color.opacity(0.8))
            .cornerRadius(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 4)
                    .fill(color)
            }
    }
}

#Preview {
    PlayerTextField(backgroundText: "Text Background", text: .constant(String()) , color: .green)
}
