import SwiftUI
import TipKit

struct CardStackView: View {
    @Environment(MovieFlickViewModel.self) var vm
    @Environment(PlayerManager.self) var playerVM
    @State var showDetail = false
    @State var isAnimating = false
    @State var showPlayerInfo = false
    
    var player : Player {
        return playerVM.players.first(where: { $0.moviesPassed < vm.swipeCount } ) ?? .emptyPlayer
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 8) {
                Text("\(player.name)'s turn")
                    .font(.title2)
                    .fontWeight(.heavy)
                Text("– \(vm.moviesLeft) movies left –")
                    .fontWeight(.light)
            }
            .contentTransition(.numericText(value: Double(vm.moviesLeft)))
            .animation(.snappy, value: vm.moviesLeft)
            .foregroundStyle(.white)
            .padding(.top)
            .onAppear {
                playerVM.selectedPlayer = player
            }
            .onChange(of: vm.moviesLeft, { oldValue, newValue in
                if newValue < 1 {
                    showPlayerInfo.toggle()
                }
            })
            .opacity(showPlayerInfo ? 0 : 1)
            .popoverTip(vm.swipeTip, arrowEdge: .top)
            
            ZStack {
                VStack(spacing: 16) {
                    if !playerVM.isLastPlayer(player: player) {
                        Text("It's your turn, \(playerVM.nextPlayer(player: player)?.name ?? "")")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundStyle(Color.white)
                        AppButton(title: "Next", isButtonDisabled: !(vm.moviesLeft < 1)) {
                            showPlayerInfo.toggle()
                            playerVM.updatePlayer(player: playerVM.selectedPlayer)
                            vm.moviesLeft = vm.moviesWithCard.count
                        }
                        .padding(.horizontal)
                    }
                }
                .onChange(of: vm.moviesLeft) { oldValue, newValue in
                    if newValue < 1 && playerVM.isLastPlayer(player: player){
                        playerVM.updatePlayer(player: playerVM.selectedPlayer)
                        if vm.resultMovies.count == 1 {
                            vm.randomMovie()
                            vm.viewState = .movieSelection
                        } else {
                            vm.viewState = .resultView
                        }
                    }
                }
                .opacity(showPlayerInfo ? 1 : 0)
                ForEach(Array(vm.moviesWithCard.enumerated()), id: \.offset) { index, movie in
                    NewCard(movie: movie)
                        .onTapGesture {
                            vm.selectedMovie = vm.movieSelected(index)
                            showDetail.toggle()
                        }
                        .offset(y: CGFloat(Double(index) * 1))
                }
            }
            .padding(.top)

            Spacer()
        }
        .animation(.easeInOut, value: showPlayerInfo)
        .id(player)
        .task {
            await vm.fetchContent()
        }
        .opacity((vm.showError || vm.noResults) ? 0 : 1)
        .sheet(isPresented: $showDetail, content: {
            if let selected = vm.selectedMovie {
                DetailView(movie: selected)
                    .presentationBackground(.ultraThinMaterial)
            }
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appBackground(gradientOpacity: 0.5)
        .overlay {
            if vm.moviesWithCard.isEmpty && !(vm.showError || vm.noResults) {
                cardStackLoading
            }
        }
        .backButton(previousViewState: .genreView)
        .overlay {
            if vm.showError {
                CustomErrorView(alertTitle: "UPS... Something went wrong", alertMessage: vm.errorMsg) {
                    Task {
                        await vm.fetchContent()
                    }
                }
                .padding(.bottom, 68)
            }
            if vm.noResults {
                CustomAlertView(errorTitle: "no_results_title", errorMessage: "no_results_message") {
                    vm.viewState = .genreView
                }
            }
        }
    }
    
    private var cardStackLoading: some View {
        VStack {
            AnimatedLogo()
            LoadingView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appBackground(gradientOpacity: 0.5)
    }
}

struct LoadingView: View {
    @State private var dotCount = 0
    private let maxDots = 3
    
    var body: some View {
        Text("Loading" + String(repeating: ".", count: dotCount))
            .font(.title2)
            .fontWeight(.heavy)
            .foregroundStyle(.white)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                    dotCount = (dotCount + 1) % (maxDots + 1)
                }
            }
    }
}

#Preview {
    CardStackView()
        .environment(MovieFlickViewModel())
        .environment(PlayerManager())
        .task {
            try? Tips.configure([
                .datastoreLocation(.applicationDefault)])
        }
}
