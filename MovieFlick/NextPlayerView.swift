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
        Group {
            if let player = vm.nextPlayer(player: vm.selectedPlayer) {
                VStack(spacing: 16) {
                    Text("It's your turn: \(player.name)")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundStyle(Color.yellow)
                    AppButton(title: "I'm Ready") {
                        vm.viewState = .swipeView
                    }
                }
                .appBackground()
            } else {
                AppButton(title: "See Matches") {
                    vm.viewState = .resultView
                }
                //ResultsView()
            }
        }
        .onAppear {
            //vm.playersName.removeFirst()
            vm.restartCount()
        }
    }
}

#Preview {
    NextPlayerView()
        .environment(MovieFlickViewModel())
}
