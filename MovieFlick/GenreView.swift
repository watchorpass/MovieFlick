import SwiftUI

struct GenreView: View {
    @Environment(MovieFlickViewModel.self) var vm

    var gridColums = [GridItem(), GridItem()]
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Select your favourite genres")
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundStyle(.yellow)
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
        .padding(.top, 48)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topLeading) {
            BackButtonComponent {
                vm.viewState = .filterView
            }
            .padding(.leading, 24)
        }
        .appBackground()
    }
}

#Preview {
    GenreView()
        .environment(MovieFlickViewModel())
}
