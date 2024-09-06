//
//  MovieSelection.swift
//  MovieFlick
//
//  Created by Alex  on 29/8/24.
//

import SwiftUI

struct MovieSelectionView: View {
    @Environment(MovieFlickViewModel.self) var vm
    @State var showSheet = false
    
    var body: some View {
        VStack {
            Text("Movie selected is ")
                .font(.title)
                .foregroundStyle(.yellow)
                .bold()
            if let selectedMovie = vm.movieSelected {
                Text(selectedMovie.title)
                    .font(.title)
                    .foregroundStyle(.yellow)
                    .bold()
                if let uiImage = selectedMovie.cardImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                } else {
                    CustomErrorView(alertTitle: "Image can not be loaded. Try again please.",
                                    alertMessage: vm.errorMsg) {
                        Task {
                            await vm.fetchMovies()
                        }
                    }
                    .padding(.bottom, 68)
                }
            }
            Spacer()
            AppButton(title: "Restart") {
                vm.showLoadingView = true
                vm.playersName = ["", ""]
                vm.viewState = .startView
            }
        }
        .padding(.horizontal, 12)
        .appBackground()
        .overlay {
            LoadingSelectingView()
                .opacity(vm.showLoadingView ? 1 : 0)
        }
    }
}

#Preview {
    MovieSelectionView()
        .environment(MovieFlickViewModel())
}
