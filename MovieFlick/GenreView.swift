import SwiftUI

struct GenreView: View {
    @Environment(MovieFlickViewModel.self) var vm

    var gridColums = [GridItem(), GridItem()]
    
    var body: some View {
        VStack {
            Text("Select your favourite genres")
                .largeTitle()
                .padding(.bottom, 20)
            Spacer()
            GeometryReader { geometry in
                ScrollView {
                    LazyVGrid(columns: gridColums, spacing: 20) {
                        ForEach(Genre.allCases, id: \.self) { genre in
                            GridCellComponent(title: genre.description, 
                                              cellSize: geometry.size.width*0.4,
                                              image: Image(genre.description)) {
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
        .environment(MovieFlickViewModel())
}
