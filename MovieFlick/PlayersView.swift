import SwiftUI

struct PlayersView: View {
    @Environment(MovieFlickViewModel.self) var vm
    @Environment(PlayerManager.self) var playerVM
    
    private var addPlayerText: (LocalizedStringKey, Bool) {
        (playerVM.players.count < 4) ? ("Add new player +", false) : ("Max. 4 players", true)
    }
    
    var body: some View {
        @Bindable var bPlayerVM = playerVM
        VStack {
            Text("Create your players")
                .font(.title)
                .bold()
                .foregroundStyle(Color.white)
            Spacer()
            VStack {
                ForEach(Array(playerVM.players.enumerated()), id: \.0) { index, player in
                    HStack {
                        PlayerTextField(backgroundText: "Player \(index + 1)", text: $bPlayerVM.players[index].name)
                        AppButton(title: "–", color: (playerVM.players.count < 3) ? .gray : .red, animation: nil, isButtonDisabled: (playerVM.players.count < 3)) {
                            playerVM.removePlayer(player: player)
                        }
                        .frame(width: 50)
                    }
                }
                AppButton(title: addPlayerText.0, isButtonDisabled: addPlayerText.1) {
                    playerVM.players.append(.emptyPlayer)
                }
                .padding(.vertical)
            }

            Spacer()
            AppButton(title: "Continue", isButtonDisabled: playerVM.isRepeatedOrEmptyPlayer()) {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                playerVM.savePlayers()
                vm.viewState = .chooseTypeView
            }
        }
        .padding(.horizontal)
        .padding(.top, 48)
        .padding(.bottom)
        .animation(.smooth, value: playerVM.players)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appBackground(gradientOpacity: 0.5)
    }
}

#Preview {
    PlayersView()
        .environment(MovieFlickViewModel())
        .environment(PlayerManager())
}
