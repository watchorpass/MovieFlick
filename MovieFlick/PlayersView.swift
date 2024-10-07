//
//  PlayersView.swift
//  MovieFlick
//
//  Created by Alex  on 16/8/24.
//

import SwiftUI

struct PlayersView: View {
    @Environment(MovieFlickViewModel.self) var vm
    
    private var addPlayerText: (String, Bool) {
        (vm.players.count < 4) ? ("Add new player +", false) : ("Max. 4 players", true)
    }
    
    var body: some View {
        @Bindable var bvm = vm
        VStack {
            Text("Create your players")
                .font(.title)
                .bold()
                .foregroundStyle(Color.white)
            Spacer()
            VStack {
                ForEach(vm.players.indices, id: \.self) { index in
                    HStack {
                        PlayerTextField(backgroundText: "Player \(index + 1)", text: $bvm.players[index].name, color: vm.isFirstOfHisName(player: vm.players[index]) ? .green : .red)
                        AppButton(title: "–", color: (vm.players.count < 3) ? .gray : .red, animation: nil, isButtonDisabled: (vm.players.count < 3)) {
                            vm.players.remove(at: index)
                        }
                        .frame(width: 50)
                    }
                }
                AppButton(title: addPlayerText.0, isButtonDisabled: addPlayerText.1) {
                    vm.players.append(.emptyPlayer)
                }
                .padding(.vertical)
            }

            Spacer()
            AppButton(title: "Continue", isButtonDisabled: (vm.playersWithoutName() || vm.noSecondNames())) {
                print(vm.noSecondNames())
                vm.viewState = .chooseTypeView
            }
        }
        .padding(.horizontal)
        .padding(.top, 48)
        .padding(.bottom)
        .animation(.smooth, value: vm.players)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appBackground()
    }
}

#Preview {
    PlayersView()
        .environment(MovieFlickViewModel())
}
