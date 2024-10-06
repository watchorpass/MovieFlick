import SwiftUI
import TipKit

struct CardStackView: View {
    @Environment(MovieFlickViewModel.self) var vm
    @State var showDetail = false
    @State var selectedMovie: Movie?
    var player : Player {
        vm.players.first(where: { $0.moviesPassed < vm.swipeCount } ) ?? .emptyPlayer
    }

    var body: some View {
        VStack {
                Text(player.name + "'s turn")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundStyle(.white)
                            .padding(.top)
                            .onAppear {
                                vm.selectedPlayer = player
                            }

                ZStack {
                    VStack(spacing: 16) {
                        if vm.isLastPlayer(player: player) {
                            AppButton(title: "See matches") {
                                vm.updatePlayer(player: vm.selectedPlayer)
                                vm.viewState = .resultView
                            }
                        } else {
                            Text("It's your turn, \(vm.nextPlayer(player: player)?.name ?? "")")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundStyle(Color.white)
                            AppButton(title: "Next") {
                                vm.updatePlayer(player: vm.selectedPlayer)
                            }
                        }
                        
                    }
                    
                    ForEach(Array(vm.moviesWithCard.enumerated()), id: \.offset) { index, movie in
                        VStack {
                            NewCard(movie: movie)
                                .onTapGesture {
                                    vm.selectedMovie = vm.movieSelected(index)
                                    showDetail.toggle()
                                }
                        }
                        .offset(y: CGFloat(Double(index) * 1))
                    }
                }
                .padding(.top)
                .popoverTip(vm.swipeTip)
                Spacer()
        }
        .id(player)
        .task {
            await vm.fetchContent()
        }
        .opacity(vm.showError ? 0 : 1)
        .sheet(isPresented: $showDetail, content: {
            if let selected = vm.selectedMovie {
                DetailView(movie: selected)
                    .presentationBackground(.ultraThinMaterial)
            } else {
                Text("HELLO")
                    .presentationBackground(.ultraThinMaterial)
            }
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appBackground()
        .overlay(alignment: .topLeading) {
            BackButtonComponent {
                vm.restartCount()
                vm.viewState = .genreView
            }
            .padding(.leading, 24)
        }
        .overlay {
            CustomErrorView(alertTitle: "UPS... Something went wrong",
                            alertMessage: vm.errorMsg) {
                Task {
                    await vm.fetchMovies()
                }
            }
                            .padding(.bottom, 68)
                            .opacity(vm.showError ? 1 : 0)
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
