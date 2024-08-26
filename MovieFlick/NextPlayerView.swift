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
        VStack {
            Text(vm.playersName.first!)
            Button {
                vm.viewState = .swipeView
            } label: {
                Text("IM READY!")
            }

        }
    }
}

#Preview {
    NextPlayerView()
}
