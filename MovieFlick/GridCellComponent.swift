//
//  GridCellComponent.swift
//  MovieFlick
//
//  Created by Fran Ochoa on 10/8/24.
//

import SwiftUI

struct GridCellComponent: View {
    let title: String = "TITULO"
    let image: Image? = nil
    var action: () -> Void
    
    var body: some View {
        ZStack() {
            (image ?? Image(systemName: "popcorn"))
                .resizable()
                .scaledToFit()
            Text(title)
        }
    }
}

#Preview {
    GridCellComponent(action: {})
}
