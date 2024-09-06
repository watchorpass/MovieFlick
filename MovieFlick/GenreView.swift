import SwiftUI
import TipKit

struct GenreView: View {
    @Environment(MovieFlickViewModel.self) var vm
    
    var gridColums = [GridItem(), GridItem()]
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Select your favourite genres")
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundStyle(.yellow)
            GeometryReader { geometry in
                ScrollView {
                    TipView(vm.swipeTip)
                    LazyVGrid(columns: gridColums, spacing: 20) {
                        ForEach(Genre.GenreListByType(type: vm.selectedType) , id: \.self) { genre in
                            GridCellComponent(title: genre.description,
                                              cellSize: geometry.size.width*0.4,
                                              image: Image("\(genre.description)\(vm.selectedType == .movie ? "" : "TV")")) {
                                vm.addGenre(genre: genre)
                            }
                          .overlay {
                              RoundedRectangle(cornerRadius: geometry.size.width*0.4/10)
                                  .stroke(lineWidth: 4)
                                  .fill(vm.selectedGenres.contains(genre) ? .yellow : .clear)
                          }
                          .padding(4)
                        }
                    }
                    Spacer(minLength: 65)
                    
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
        .overlay(alignment: .bottom) {
            if !vm.selectedGenres.isEmpty {
                AppButton(title: "Continue") {
                    vm.viewState = .swipeView
                }
                .popoverTip(vm.genreTip)
            }
        }
        .appBackground()
    }
}

#Preview {
    GenreView()
        .environment(MovieFlickViewModel())
}
