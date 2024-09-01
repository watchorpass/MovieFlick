//
//  DetailView.swift
//  MovieFlick
//
//  Created by Alex  on 29/8/24.
//

import SwiftUI

struct DetailView: View {
    @Environment(MovieFlickViewModel.self) var vm
    var movie: Movie? = nil
    
    var body: some View {
        VStack (spacing: 32) {
            if let uiImage = movie?.cardImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text(movie?.overview ?? "Overview no available")
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                StarsRateComponent(rate: movie?.voteAverage ?? 0.0, starSize: 40)
            } else {
                CustomErrorView(alertTitle: "UPS... Something went wrong",
                                alertMessage: vm.errorMsg) {
                    Task {
                        await vm.fetchMovies()
                    }
                }
                .padding(.bottom, 68)
            }
        }
        .appBackground()
    }
}

#Preview {
    DetailView()
        .environment(MovieFlickViewModel())
}
