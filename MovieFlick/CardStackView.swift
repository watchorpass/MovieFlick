import SwiftUI

struct CardStackView: View {
    @Environment(MovieFlickViewModel.self) var viewModel
    
    var body: some View {
        VStack {
            Text("Left movies: \(viewModel.moviesWithCard.count)")
                .font(.title2)
                .foregroundStyle(.white)
            ZStack {
                ForEach(viewModel.moviesWithCard) { movie in
                    NewCard(movie: movie)
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appBackground()
    }
}

#Preview {
    CardStackView()
}
