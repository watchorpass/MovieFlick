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
        (vm.playersName.count < 4) ? ("Add new player +", false) : ("Max. 4 players", true)
    }
    
    var body: some View {
        @Bindable var bvm = vm
        VStack {
            Text("Create your players")
                .font(.title)
                .bold()
                .foregroundStyle(Color.yellow)
            Spacer()
            ForEach(vm.playersName.indices, id: \.self) { index in
                HStack {
                    PlayerTextField(backgroundText: "Player \(index + 1)", text: $bvm.playersName[index], color: .green)
                    AppButton(title: "–", color: (vm.playersName.count < 3) ? .gray : .red, animation: nil, isButtonDisabled: (vm.playersName.count < 3)) {
                        vm.playersName.remove(at: index)
                    }
                    .frame(width: 50)
                }
            }
            AppButton(title: addPlayerText.0, color: .yellow, isButtonDisabled: addPlayerText.1) {
                vm.playersName.append("")
            }
            Spacer()
            AppButton(title: "Continue", isButtonDisabled: vm.playersWithoutName()) {
                vm.viewState = .chooseTypeView
            }
        }
        .padding(.top, 48)
        .animation(.smooth, value: vm.playersName)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appBackground()
    }
}

#Preview {
    PlayersView()
        .environment(MovieFlickViewModel())
}
