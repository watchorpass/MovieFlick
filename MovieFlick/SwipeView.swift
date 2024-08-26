//
//  SwipeView.swift
//  MovieFlick
//
//  Created by Alberto Alegre Bravo on 19/8/24.
//

import SwiftUI

struct SwipeView: View {
    var body: some View {
        ZStack {
            ForEach(Array(myMockArray.enumerated()), id: \.element.id) { index, movie in
                SwipeCardComponent(imageOffset: CGFloat(-index), imageURL: movie.url) {
                    print("Set Yes")
                } negativeAction: {
                    print("set No")
                }
            }
        }
        .appBackground()
    }
}

#Preview {
    SwipeView()
}
