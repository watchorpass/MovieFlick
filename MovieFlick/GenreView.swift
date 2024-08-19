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
            LazyVGrid(columns: [GridItem(), GridItem()], spacing: 40) {
                ForEach(genreList) { genres in
                    GridCellComponent(title: genres.name, cellSize: 160, color: .indigo, action: {})
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appBackground()
    }
}

#Preview {
    GenreView(filteredType: "Popular", genreList: [Genre(name: "Action", id: 1), Genre(name: "Comedy", id: 2), Genre(name: "Thriller", id: 3), Genre(name: "Romantic", id: 4), Genre(name: "Drama", id: 5)])
}
