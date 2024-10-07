//
//  ProvidersView.swift
//  MovieFlick
//
//  Created by Fran Malo on 5/9/24.
//

import SwiftUI

struct ProvidersView: View {
    @Environment(MovieFlickViewModel.self) var vm
    
    var gridColums = [GridItem(), GridItem()]
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Select providers")
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundStyle(.white)
            GeometryReader { geometry in
                ScrollView {
                    LazyVGrid(columns: gridColums, spacing: 20) {
                        ForEach(Provider.avaibleProviders, id: \.self) { provider in
                            GridCellComponent(title: "", cellSize: geometry.size.width*0.40,
                                              image: Image("\(provider)")) {
                                vm.addprovider(provider: provider)
                            }
                          .overlay {
                              RoundedRectangle(cornerRadius: geometry.size.width*0.4/10)
                                  .stroke(lineWidth: 4)
                                  .fill(vm.selectedProviders.contains(provider) ? .white : .clear)
                          }
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
                AppButton(title: "Continue", color: .gray) {
                    vm.viewState = .genreView
                }
                .padding()
            }
        }
        .appBackground()
    }
}

#Preview {
    ProvidersView()
        .environment(MovieFlickViewModel())
}
