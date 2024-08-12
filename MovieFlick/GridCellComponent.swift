//
//  GridCellComponent.swift
//  MovieFlick
//
//  Created by Fran Ochoa on 10/8/24.
//

import SwiftUI

struct GridCellComponent: View {
    let title: String
    let image: Image? = nil
    let cellSize: CGFloat
    var action: () -> Void
    
    var gradient = LinearGradient(
        colors: [.black.opacity(0.8), .black.opacity(0)],
        startPoint: .bottom,
        endPoint: .center
    )
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            (image ?? Image(systemName: "popcorn"))
                .resizable()
                .scaledToFit()
                .padding()
                .frame(width: cellSize, height: cellSize)
                .background(.ultraThinMaterial) // por si sale el placeholder popcorn, que se vea el fondo difuminado.
            gradient
            Text(title)
                .fontWeight(.light)
                .foregroundColor(.white)
                .lineLimit(1)
                .padding(8)
                .allowsTightening(true)
                .truncationMode(.middle) // si una pelicula es la 2 o el final del título es lo importante. De esta manera se permite leer correcetamente.
        }
        .clipShape(RoundedRectangle(cornerRadius: cellSize/15))
        .frame(width: cellSize, height: cellSize)
    }
}

#Preview("large") {
    GridCellComponent(title: "Movie title",cellSize: 300, action: {})
}

#Preview("medium") {
    GridCellComponent(title: "Movie title",cellSize: 200, action: {})
}

#Preview("small") {
    GridCellComponent(title: "Movie title",cellSize: 150, action: {})
}
