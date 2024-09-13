import SwiftUI
import TipKit

struct CardStackView: View {
    @Environment(MovieFlickViewModel.self) var vm

    var body: some View {
        VStack {
            if let name = vm.playersName.first {
                Text(name + "'s turn")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundStyle(.yellow)
                    .padding(.top)
            }
            ZStack {
                ForEach(Array(vm.moviesWithCard.enumerated()), id: \.offset) { index, movie in
                    NewCard(movie: movie)
                        .offset(y: CGFloat(Double(index) * 1))
                }
            }
            .padding(.top, 48)
            .popoverTip(vm.swipeTip)
            Spacer()
        }
        .task {
            await vm.fetchContent()
        }
        .opacity(vm.showError ? 0 : 1)
        .onChange(of: vm.swipeCount, { oldValue, newValue in
            if newValue == 0 {
                vm.viewState = .playerTwoView
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
