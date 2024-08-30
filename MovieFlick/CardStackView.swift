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
        .task {
            await vm.fetchMovies()
        }
        .onChange(of: vm.swipeCount, { oldValue, newValue in
            if newValue == 0 {
                vm.viewState = .playerTwoView
            }
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appBackground()
    }
}

#Preview {
    CardStackView()
        .environment(MovieFlickViewModel())
}
