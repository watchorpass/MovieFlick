//
//  ResultsView.swift
//  MovieFlick
//
//  Created by Alberto Alegre Bravo on 27/8/24.
//

import SwiftUI

struct ResultsView: View {
    @Environment(MovieFlickViewModel.self) var vm
    let items: [GridItem] = [GridItem(), GridItem()]
    @State var showDetail = false
    
    var body: some View {
        VStack(spacing: 26) {
            Text("MOVIE MATCHES")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundStyle(Color.yellow)
            
            ScrollView {
                LazyVGrid(columns: items) {
                    ForEach(vm.resultMovies) { movie in
                        if let image = movie.cardImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 160)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay(alignment: .bottomTrailing) {
                                    Image(systemName: "info.circle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20)
                                        .foregroundStyle(.yellow)
                                        .padding(16)
                                        .onTapGesture {
                                            vm.selectedMovie = movie
                                            showDetail.toggle()
                                        }
                                }
                        } else {
                            Image(systemName: "popcorn")
                        }
                    }
                }
            }
            HStack {
                AppButton(title: "Restart Game") {
                    vm.viewState = .startView
                }
                
                AppButton(title: "Choose one") {
                    
                }
            }
        }
        .sheet(isPresented: $showDetail, content: {
            if let movie = vm.selectedMovie {
                DetailView(movie: movie)
            }
        })
        .padding()
        .appBackground()
    }
}

#Preview {
    ResultsView()
        .environment(MovieFlickViewModel())
}
