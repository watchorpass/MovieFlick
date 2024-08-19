import SwiftUI

struct FilterView: View {
    let selectedType: String
    
    var body: some View {
        VStack {
            Text(selectedType.uppercased())
                .font(.title)
                .bold()
                .foregroundStyle(.yellow)
            Text("Select which list you want to see")
                .foregroundStyle(.yellow)
            Spacer()
            GridCellComponent(title: "Popular", cellSize: 300, image: Image(.interestellar), action: {})
                .padding()
            GridCellComponent(title: "Top rated", cellSize: 300, image: Image(.theLastOfUs), action: {})
                .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appBackground()
    }
}

#Preview {
    FilterView(selectedType: "Movies")
}
