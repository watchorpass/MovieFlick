import SwiftUI

struct Genre: Identifiable {
    let name: String
    let id: Int
}

struct GenreView: View {
    let filteredType: String
    let genreList: [Genre]
    
    var body: some View {
        VStack {
            Text(filteredType.uppercased())
                .font(.title)
                .bold()
                .foregroundStyle(.yellow)
            Text("Select your favourite genres")
                .foregroundStyle(.yellow)
            Spacer()
            GeometryReader { geometry in
                ScrollView {
                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: 20) {
                        ForEach(genreList) { genres in
                            GridCellComponent(title: genres.name, cellSize: geometry.size.width*0.4, color: .teal, action: {})
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appBackground()
    }
}

#Preview {
    GenreView(filteredType: "Popular", genreList: [Genre(name: "Action", id: 1), Genre(name: "Comedy", id: 2), Genre(name: "Thriller", id: 3), Genre(name: "Romantic", id: 4), Genre(name: "Drama", id: 5), Genre(name: "Drama 6", id: 6), Genre(name: "Drama 7", id: 7), Genre(name: "Drama 8", id: 8), Genre(name: "Drama 9", id: 9)])
}
