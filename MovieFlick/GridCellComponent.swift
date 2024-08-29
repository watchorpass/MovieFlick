//
//  GridCellComponent.swift
//  MovieFlick
//
//  Created by Fran Ochoa on 10/8/24.
//

import SwiftUI

struct GridCellComponent: View {
    let title: String
    let cellSize: CGFloat
    var image: Image? = nil
    var color: Color? = nil
    var action: () -> Void
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if let color { color }
            else {
                ZStack(alignment: .bottom) {
                    (image ?? Image(systemName: "popcorn"))
                        .resizable()
                        .scaledToFill()
                        .frame(width: cellSize, height: cellSize)
                        .background(.ultraThinMaterial)
                    ZStack(alignment: .bottomLeading) {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: cellSize, height: cellSize/2)
                            .foregroundStyle(LinearGradient(colors: [.black, .clear],
                                                            startPoint: .bottom,
                                                            endPoint: .top))
                    }
                }
            }
            Text(title)
                .font(.custom(typography, size: ((cellSize > 250) ? 38 : 22)))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color(.white))
                .lineLimit(2)
                .fontWeight(.semibold)
                .padding(.vertical, 10)
                .allowsTightening(true)
                .truncationMode(.middle)
        }
        .onTapGesture(perform: action)
        .clipShape(RoundedRectangle(cornerRadius: cellSize/10))
        .frame(width: cellSize, height: cellSize)
    }
}

#Preview("Different sizes") {
    VStack(spacing: 10) {
        GridCellComponent(title: "Movie title",cellSize: 300, action: {})
        Text("300")
        GridCellComponent(title: "Genre name",cellSize: 200, color: .purple, action: {})
        Text("200 and color")
        GridCellComponent(title: "Large title movie just for checking long text 2",cellSize: 150, action: {})
        Text("150 and long text")
    }
}

#Preview("Genres") {
    Grid {
        GridCellComponent(title: "Action", cellSize: 150, image: Image("Inside Man Poster"), action: {})
        GridCellComponent(title: "Fiction", cellSize: 150, image: Image("Breaking Bad Poster"), action: {})
    }
}

#Preview("Film & TVseries") {
    VStack {
        GridCellComponent(title: "Films", cellSize: 350, image: Image("Inside Man Poster"), action: {})
        GridCellComponent(title: "TV Series", cellSize: 350, image: Image("Breaking Bad Poster"), action: {})
    }
}
