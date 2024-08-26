//
//  NextPlayerView.swift
//  MovieFlick
//
//  Created by Alberto Alegre Bravo on 26/8/24.
//

import SwiftUI

struct NextPlayerView: View {
    @Environment(MovieFlickViewModel.self) var vm

    var body: some View {
        if let player = vm.playersName.first {
            VStack {
                Text(player)
                Button {
                    vm.viewState = .swipeView
                } label: {
                    Text("IM READY!")
                }
                
            }
        } else {
            VStack {
                ForEach(vm.resultMovies) { movie in
                    Text(movie.title)
                }
            }
        }
        
    }
}

#Preview {
    NextPlayerView()
        .environment(MovieFlickViewModel())
}
