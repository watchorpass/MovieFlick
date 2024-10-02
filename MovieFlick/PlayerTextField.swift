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
        TextField("", text: $text, prompt: Text(backgroundText).foregroundStyle(.white))
            .foregroundStyle(.white)
            .accentColor(.white)
            .multilineTextAlignment(.center)
            .font(.title)
            .bold()
            .foregroundColor(.primary)
            .padding()
            .frame(maxWidth: 350, maxHeight: 50)
            .background(.white.opacity(0.3))
            .cornerRadius(10)
    }
}

#Preview {
    VStack {
        PlayerTextField(backgroundText: "Text Background", text: .constant(String()) , color: .green)
    }
    .frame(width: 300, height: 300)
    .background {
        Color.purple
    }
}
