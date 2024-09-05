//
//  ProvidersView.swift
//  MovieFlick
//
//  Created by Fran Malo on 5/9/24.
//

import SwiftUI

struct ProvidersView: View {
    @Environment(MovieFlickViewModel.self) var vm
    
    var gridColums = [GridItem(), GridItem(), GridItem()]
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Select providers")
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundStyle(.yellow)
            GeometryReader { geometry in
                ScrollView {
                    LazyVGrid(columns: gridColums, spacing: 20) {
                        ForEach(Provider.avaibleProviders, id: \.self) { provider in
                            CellProvider(cellSize: 80, image: Image("\(provider)")) {
                                vm.addprovider(provider: provider)
                            }
                            .clipShape(Circle())
                            .overlay(Circle().stroke(vm.selectedProviders.contains(provider) ? .yellow : .gray, lineWidth: 4))
                            
                          .padding(4)
                        }
                    }
                    Spacer(minLength: 65)
                }
            }
        }
        .padding(.top, 48)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topLeading) {
            BackButtonComponent {
                vm.viewState = .filterView
            }
            .padding(.leading, 24)
        }
        .overlay(alignment: .bottom) {
            if !vm.selectedProviders.isEmpty {
                AppButton(title: "Continue") {
                    vm.viewState = .genreView
                }
            }
        }
        .appBackground()
    }
}

#Preview {
    ProvidersView()
        .environment(MovieFlickViewModel())
}
