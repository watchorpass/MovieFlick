import SwiftUI
import TipKit

struct CardStackView: View {
    @Environment(MovieFlickViewModel.self) var vm
    @State var showDetail = false
    @State var isAnimating = false
    @State var showPlayerInfo = false
    
    var player : Player {
        vm.players.first(where: { $0.moviesPassed < vm.swipeCount } ) ?? .emptyPlayer
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
            .foregroundStyle(.white)
            .padding(.top)
            .onAppear {
                vm.selectedPlayer = player
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
                    if !vm.isLastPlayer(player: player) {
                        Text("It's your turn, \(vm.nextPlayer(player: player)?.name ?? "")")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundStyle(Color.white)
                        AppButton(title: "Next", isButtonDisabled: !(vm.moviesLeft < 1)) {
                            showPlayerInfo.toggle()
                            vm.updatePlayer(player: vm.selectedPlayer)
                            vm.moviesLeft = vm.moviesWithCard.count
                        }
                        .padding(.horizontal)
                    }
                }
                .onChange(of: vm.moviesLeft) { oldValue, newValue in
                    if newValue < 1 && vm.isLastPlayer(player: player){
                        vm.updatePlayer(player: vm.selectedPlayer)
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
        .opacity(vm.showError ? 0 : 1)
        .sheet(isPresented: $showDetail, content: {
            if let selected = vm.selectedMovie {
                DetailView(movie: selected)
                    .presentationBackground(.ultraThinMaterial)
            }
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appBackground(gradientOpacity: 0.5)
        .overlay {
            if vm.moviesWithCard.isEmpty && !vm.showError {
                cardStackLoading
            }
        }
        .overlay(alignment: .topLeading) {
            BackButtonComponent {
                vm.restartCount()
                vm.viewState = .genreView
            }
            .padding()
        }
        .overlay {
            if vm.showError {
                CustomErrorView(alertTitle: "UPS... Something went wrong", alertMessage: vm.errorMsg) {
                    Task {
                        await vm.fetchContent()
                    }
                }
                .padding(.bottom, 68)
            }
        }
    }
    
    var cardStackLoading: some View {
        VStack {
            Image(.rebrandingMovieFlick)
                .resizable()
                .scaledToFit()
                .frame(width: 250)
                .padding()
                .rotationEffect(.degrees(isAnimating ? 2 : -2))
                .animation(
                    Animation.easeInOut(duration: 1.2)
                        .repeatForever(autoreverses: true),
                    value: isAnimating
                )
                .onAppear {
                    isAnimating = true
                }
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
        .task {
            try? Tips.configure([
                .datastoreLocation(.applicationDefault)])
        }
}
