import SwiftUI

struct GenreView: View {
    @Environment(MovieFlickViewModel.self) var vm

    var gridColums = [GridItem(), GridItem()]
    
    var body: some View {
        VStack {
            Text("Select your favourite genres")
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundStyle(.yellow)
            Spacer()
            GeometryReader { geometry in
                ScrollView {
                    LazyVGrid(columns: gridColums, spacing: 20) {
                        ForEach(Genre.allCases, id: \.self) { genre in
                            GridCellComponent(title: genre.description, 
                                              cellSize: geometry.size.width*0.4,
                                              image: Image(.interestellar)) {
                                vm.selectedGenre = genre
                                vm.viewState = .swipeView
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appBackground()
    }
}

#Preview {
    GenreView()
}
