//
//  ResultsView.swift
//  MovieFlick
//
//  Created by Alberto Alegre Bravo on 27/8/24.
//

import SwiftUI
import TipKit

struct ResultsView: View {
    @Environment(MovieFlickViewModel.self) var vm
    let items: [GridItem] = [GridItem(), GridItem()]
    @State var showDetail = false
    
    var body: some View {
        VStack(spacing: 26) {
            Text("MATCHES")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundStyle(Color.white)
            ScrollView {
                resultMovies
            }
            .safeAreaInset(edge: .bottom) {
                HStack {
                    if !vm.resultMovies.isEmpty {
                        AppButton(title: "Restart Game", color: .gray) {
                            vm.swipeTip.invalidate(reason: .actionPerformed)
                            vm.resetGame()
                            vm.viewState = .startView
                        }
                        AppButton(title: "Choose one", color: .gray) {
                            vm.swipeTip.invalidate(reason: .actionPerformed)
                            vm.randomMovie()
                            vm.viewState = .movieSelection
                        }
                        .popoverTip(vm.chooseOneTip)
                    }
                }
                .padding()
            }
        }
        .overlay {
            if vm.resultMovies.isEmpty {
                CustomAlertView(errorTitle: "NO MATCHES FOUND", errorMessage: "Oops! Looks like there’s no match this time… 🤔 Maybe it’s time to rethink your movie friendship. Or, you can play again and try your luck! 🎬") {
                    vm.resetGame()
                    vm.viewState = .startView
                }
            }
        }
        .sheet(isPresented: $showDetail, content: {
            if let movie = vm.selectedMovie {
                DetailView(movie: movie)
            }
        })
        .padding()
        .appBackground(gradientOpacity: 0.5)
    }
    
    var resultMovies: some View {
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
                                .foregroundStyle(.white)
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
}

#Preview {
    ResultsView()
        .environment(MovieFlickViewModel())
}
