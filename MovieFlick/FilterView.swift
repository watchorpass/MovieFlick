import SwiftUI

struct FilterView: View {
    let selectedType: String
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text(selectedType.uppercased())
                    .font(.title)
                    .bold()
                    .foregroundStyle(.yellow)
                Text("Select which list you want to see")
                    .foregroundStyle(.yellow)
                Spacer(minLength: 10)
                ScrollView {
                    GridCellComponent(title: "Popular", cellSize: geometry.size.width*0.8, image: Image(.interestellar), action: {})
                        .padding()
                    GridCellComponent(title: "Top rated", cellSize: geometry.size.width*0.8, image: Image(.theLastOfUs), action: {})
                        .padding()
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .appBackground()
        }
    }
}

#Preview {
    FilterView(selectedType: "Movies")
}
