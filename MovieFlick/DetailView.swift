//
//  DetailView.swift
//  MovieFlick
//
//  Created by Alex  on 29/8/24.
//

import SwiftUI

struct DetailView: View {
    @Environment(MovieFlickViewModel.self) var vm
    
    var body: some View {
        VStack (spacing: 32) {
            if let uiImage = vm.movieSelected.cardImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text(vm.movieSelected.overview)
                    .foregroundStyle(.white)
                    .padding()
            } else {
                // poner el error view de deadpool
            }
            AppButton(title: "Restart") {
                vm.playersName = ["", ""]
                vm.viewState = .startView
            }
        }
        .appBackground()
    }
}

#Preview {
    DetailView()
        .environment(MovieFlickViewModel())
}
