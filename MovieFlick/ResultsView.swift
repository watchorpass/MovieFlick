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
                        } else {
                            Image(systemName: "popcorn")
                        }
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                HStack {
                    AppButton(title: "Restart Game") {
                        vm.showLoadingView = true
                        vm.playersName = ["", ""]
                        vm.viewState = .startView
                    }
                    
                    AppButton(title: "Choose one") {
                        vm.randomMovie()
                        vm.wait5Segs()
                        vm.viewState = .movieSelection
                    }
                }
                .padding()
            }
        }
        .appBackground()
    }
}

#Preview {
    ResultsView()
        .environment(MovieFlickViewModel())
}
