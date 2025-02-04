import SwiftUI

struct PlayersView: View {
    @Environment(MovieFlickViewModel.self) var vm
    
    private var addPlayerText: (LocalizedStringKey, Bool) {
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
                ForEach(Array(vm.players.enumerated()), id: \.0) { index, player in
                    HStack {
                        PlayerTextField(backgroundText: "Player \(index + 1)", text: $bvm.players[index].name)
                        AppButton(title: "–", color: (vm.players.count < 3) ? .gray : .red, animation: nil, isButtonDisabled: (vm.players.count < 3)) {
                            vm.removePlayer(player: player)
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
            AppButton(title: "Continue", isButtonDisabled: vm.isRepeatedOrEmptyPlayer()) {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                vm.savePlayer()
                vm.viewState = .chooseTypeView
            }
        }
        .padding(.horizontal)
        .padding(.top, 48)
        .padding(.bottom)
        .animation(.smooth, value: vm.players)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appBackground(gradientOpacity: 0.5)
    }
}

#Preview {
    PlayersView()
        .environment(MovieFlickViewModel())
}
