//
//  PlayerTextField.swift
//  MovieFlick
//
//  Created by Alex  on 21/8/24.
//

import SwiftUI

struct PlayerTextField: View {
    var backgroundText: LocalizedStringKey
    @Binding var text: String
    var color: Color
    var body: some View {
        TextField(backgroundText, text: $text, prompt: Text(backgroundText).foregroundStyle(.white.opacity(0.5)))
            .foregroundStyle(.white)
            .accentColor(.white)
            .multilineTextAlignment(.center)
            .font(.title)
            .bold()
            .foregroundColor(.primary)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(.white.opacity(0.3))
            .cornerRadius(10)
    }
}

#Preview {
    PlayerTextField(backgroundText: "Text Background", text: .constant(String()) , color: .green)
        .appBackground()
}
