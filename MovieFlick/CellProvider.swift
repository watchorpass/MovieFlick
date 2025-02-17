import SwiftUI

struct CellProvider: View {
    let cellSize: CGFloat
    var image: Image? = nil
    var color: Color? = nil
    var action: () -> Void
    
    var body: some View {
        Button {
            withAnimation(.spring) {
                action()
            }
        } label: {
            (image ?? Image(systemName: "popcorn"))
                .resizable()
                .scaledToFill()
                .frame(width: cellSize, height: cellSize)
                .background(.ultraThinMaterial)

                .shadow(radius: 10)
        }
    }
}



#Preview ("Providers") {
    Grid {
        CellProvider(cellSize: 100, image: Image("AppleTV"), action: {})
        CellProvider(cellSize: 100, image: Image("Netflix"), action: {})
        CellProvider(cellSize: 100, image: Image("PrimeVideo"), action: {})
        CellProvider(cellSize: 100, image: Image("Crunchyroll"), action: {})
        CellProvider(cellSize: 100, image: Image("DisneyPlus"), action: {})
        CellProvider(cellSize: 100, image: Image("Filmin"), action: {})
        CellProvider(cellSize: 100, image: Image("MAX"), action: {})

    }
}
