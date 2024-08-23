import SwiftUI

struct GenreView: View {
    let filteredType: String
    
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
                        ForEach(Genre.allCases, id: \.self) { genre in
                            GridCellComponent(title: "genre.description", cellSize: geometry.size.width*0.4, image: Image(.interestellar), action: {})
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
    GenreView(filteredType: "Popular")
}
