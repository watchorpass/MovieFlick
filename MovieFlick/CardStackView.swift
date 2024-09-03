import SwiftUI
import TipKit

struct CardStackView: View {
    @Environment(MovieFlickViewModel.self) var vm

    var body: some View {
        VStack {
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
            await vm.fetchMovies()
        }
        .opacity(vm.showError ? 0 : 1)
        .onChange(of: vm.swipeCount, { oldValue, newValue in
            if newValue == 0 {
                vm.viewState = .playerTwoView
            }
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appBackground()
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
