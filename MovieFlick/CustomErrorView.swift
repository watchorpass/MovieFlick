//
//  CustomErrorView.swift
//  MovieFlick
//
//  Created by Alberto Alegre Bravo on 28/8/24.
//

import SwiftUI

struct CustomErrorView: View {
    let alertTitle: LocalizedStringKey
    var alertMessage: LocalizedStringKey?
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text(alertTitle)
                .font(.title2)
                .fontWeight(.heavy)
            if let alertMessage {
                Text(alertMessage)
                    .fontWeight(.regular)
                    .padding()
            }
            Button {
                action()
            } label: {
                Text("Try again")
            }
            .font(.title2)
            .buttonStyle(.bordered)
            .tint(.white)
            .foregroundStyle(Color.white)
            
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
    CustomErrorView(alertTitle: "UPS... Something went wrong", alertMessage: "Check your internet connection and try again.") {}
        .appBackground(gradientOpacity: 0.5)
}
