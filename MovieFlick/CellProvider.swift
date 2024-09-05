//
//  CellProvider.swift
//  MovieFlick
//
//  Created by Fran Malo on 5/9/24.
//

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
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
        }
    }
}



#Preview ("Providers") {
    Grid {
        CellProvider(cellSize: 100, image: Image("appleTV"), action: {})
        CellProvider(cellSize: 100, image: Image("netflix"), action: {})
        CellProvider(cellSize: 100, image: Image("amazonPrimeVideo"), action: {})
        CellProvider(cellSize: 100, image: Image("crunchyroll"), action: {})
        CellProvider(cellSize: 100, image: Image("disneyPlus"), action: {})
        CellProvider(cellSize: 100, image: Image("filmin"), action: {})
        CellProvider(cellSize: 100, image: Image("hboMax"), action: {})

    }
}
