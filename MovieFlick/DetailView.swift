//
//  DetailView.swift
//  MovieFlick
//
//  Created by Alex  on 4/9/24.
//

import SwiftUI

struct DetailView: View {
    var movie: Movie
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
                if let uiImage = movie.cardImage {
                    ZStack(alignment: .bottom) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        ZStack(alignment: .bottom) {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(maxWidth: .infinity, maxHeight: 300)
                                .foregroundStyle(LinearGradient(colors: [.black, .clear, .clear, .clear],
                                                                startPoint: .bottom,
                                                                endPoint: .top))
                        }
                    }
                } else {
                    Image(systemName: "popcorn")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                VStack(alignment: .leading) {
                    HStack{
                        Text("Rate:")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(.white)
                        StarsRateComponent(rate: movie.voteAverage, starSize: 18)
                        Spacer()
                        Text(movie.releaseDate)
                            .foregroundStyle(.white)
                    }
                    Text(movie.overview)
                        .font(.title2)
                        .foregroundStyle(.white)
                }
                .padding(.horizontal)
            }
            .padding(.bottom, UIDevice.bottomInsetSize)
        }
        .appBackground(gradientOpacity: 0.5)
        .ignoresSafeArea()
    }
}

