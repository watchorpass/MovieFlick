//
//  StartView.swift
//  MovieFlick
//
//  Created by Alex  on 16/8/24.
//

import SwiftUI

struct StartView: View {
    @Environment(MovieFlickViewModel.self) var vm
    
    var body: some View {
        VStack {
            Spacer()
            Image(.logoLetra)
                .resizable()
                .scaledToFit()
                .padding()
            Spacer()
            AppButton(title: "Start", color: .white) {
                vm.viewState = .playersView
            }
            Spacer()
            VStack {
                Text("This product uses the TMDB API but is not endorsed or certified by TMDB.")
                    .foregroundStyle(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
                Image(.tmdbLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 12)
            }
        }
        .padding(.horizontal)
        .appBackground(gradientOpacity: 0.5)
        .overlay (alignment: .topTrailing){
            Button {
                vm.viewState = .aboutLegalView
            } label: {
                Image(systemName: "info.square")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                    .foregroundStyle(.white)
            }
            .padding()
            .buttonStyle(PlainButtonStyle())

        }
    }

}

#Preview {
    StartView()
        .environment(MovieFlickViewModel())
}
