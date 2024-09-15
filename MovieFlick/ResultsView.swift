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
            Text("\(vm.selectedType.rawValue) MATCHES")
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
            .safeAreaInset(edge: .bottom) {
                HStack {
                    AppButton(title: "Restart Game") {
                        vm.swipeTip.invalidate(reason: .actionPerformed)
                        vm.showLoadingView = true
                        vm.playersName = ["", ""]
                        vm.viewState = .startView
                    }
                    
                    AppButton(title: "Choose one") {
                        vm.swipeTip.invalidate(reason: .actionPerformed)
                        vm.randomMovie()
                        vm.viewState = .movieSelection
                    }
                    .popoverTip(vm.chooseOneTip)
                }
                .padding()
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
