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
                .font(.title)
                .bold()
                .foregroundStyle(.white)
            Spacer()
            GridCellComponent(title: "Films", cellSize: UIDevice.width * 0.7, image: Image(.films)) {
                vm.selectedType = .movie
                vm.viewState = .filterView
            }
                .padding()
            GridCellComponent(title: "TV Series", cellSize: UIDevice.width * 0.7, image: Image(.tvseries)) {
                vm.selectedType = .serie
                vm.viewState = .filterView
            }
                .padding()
            Spacer()
        }
        .padding(.top, 48)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topLeading) {
            BackButtonComponent {
                vm.viewState = .playersView
            }
            .padding()
        }
        .appBackground(gradientOpacity: 0.5)
    }
}

#Preview {
    ChooseTypeView()
        .environment(MovieFlickViewModel())
}
