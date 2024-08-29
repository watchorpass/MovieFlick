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
            Text("Movie Flick")
                .font(.custom("Lonely Cake", size: 70))
                .foregroundStyle(.yellow)
            Text("Movie Flick")
                .font(.custom("Intensa Fuente", size: 80))
                .foregroundStyle(.yellow)
            Text("Movie Flick")
                .font(.custom("Sparky Stones", size: 70))
                .foregroundStyle(.yellow)
            Spacer()
            AppButton(title: "Start") {
                vm.viewState = .playersView
            }
        }
        .padding(.bottom, 100)
        .appBackground(gradientOpacity: 0.5)
    }
}

#Preview {
    StartView()
        .environment(MovieFlickViewModel())
}
