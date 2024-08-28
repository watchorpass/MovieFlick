import SwiftUI

struct CardStackView: View {
    @Environment(MovieFlickViewModel.self) var vm
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(vm.moviesWithCard) { movie in
                    NewCard(movie: movie)
                }
            }
            Spacer()
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
            CustomErrorView(alertTitle: "UPS... Algo ha salido mal",
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
}
