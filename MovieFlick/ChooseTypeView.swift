//
//  ChooseTypeView.swift
//  MovieFlick
//
//  Created by Alex  on 18/8/24.
//

import SwiftUI

struct ChooseTypeView: View {
    @Environment(MovieFlickViewModel.self) var vm

    var body: some View {
        VStack {
            Text("What to see")
                .largeTitle()
            Spacer()
            GridCellComponent(title: "Films", cellSize: 300, image: Image(.interestellar)) {
                vm.viewState = .filterView
            }
                .padding()
            GridCellComponent(title: "TV Series", cellSize: 300, image: Image(.theLastOfUs)) {
                vm.viewState = .filterView
            }
                .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appBackground()
    }
}

#Preview {
    ChooseTypeView()
        .environment(MovieFlickViewModel())
}
