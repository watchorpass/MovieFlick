//
//  ChooseTypeView.swift
//  MovieFlick
//
//  Created by Alex  on 18/8/24.
//

import SwiftUI

struct ChooseTypeView: View {
    var body: some View {
        VStack {
            Text("What to see")
                .font(.title)
                .bold()
                .foregroundStyle(.yellow)
            Spacer()
            GridCellComponent(title: "Films", cellSize: 300, image: Image(.interestellar), action: {})
                .padding()
            GridCellComponent(title: "TV Series", cellSize: 300, image: Image(.theLastOfUs), action: {})
                .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appBackground()
    }
}

#Preview {
    ChooseTypeView()
}
