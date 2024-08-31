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
            .background(.ultraThinMaterial.opacity(0.4))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .fill(.white)
                    .shadow(radius: 2)
            }
        }
        .foregroundStyle(Color.yellow)
    }
}

#Preview {
    CustomErrorView(alertTitle: "UPS... Something went wrong", alertMessage: "Check your internet connection and try again.") {}
        .appBackground()
}