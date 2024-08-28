//
//  CustomErrorView.swift
//  MovieFlick
//
//  Created by Alberto Alegre Bravo on 28/8/24.
//

import SwiftUI

struct CustomErrorView: View {
    let alertTitle: String
    var alertMessage: String?
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Image(.deadpoolimage)
                .resizable()
                .scaledToFit()
                .frame(width: 300)
            VStack(spacing: 12) {
                Text(alertTitle)
                    .font(.title2)
                    .fontWeight(.heavy)
                if let alertMessage {
                    Text(alertMessage)
                        .font(.title3)
                        .fontWeight(.regular)
                        .padding(.bottom)
                }
                Button {
                    action()
                } label: {
                    Text("Try again")
                }
                .font(.title2)
                .buttonStyle(.bordered)
                .tint(.yellow)
                .foregroundStyle(Color.white)
                
            }
            .padding()
            .frame(width: 300, height: 220)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .border(.white, width: 2)
            .background(.ultraThinMaterial.opacity(0.4))
            .shadow(radius: 2)
        }
        .foregroundStyle(Color.yellow)
    }
}

#Preview {
    CustomErrorView(alertTitle: "UPS... Algo ha salido mal", alertMessage: "Comprueba tu conexión a internet e inténtalo de nuevo") {}
        .appBackground()
}
