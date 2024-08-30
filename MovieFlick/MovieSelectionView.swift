//
//  MovieSelection.swift
//  MovieFlick
//
//  Created by Alex  on 29/8/24.
//

import SwiftUI

struct MovieSelectionView: View {
    @Environment(MovieFlickViewModel.self) var vm
    @State var showSheet = false
    
    var body: some View {
        VStack {
            Text("Movie selected is ")
                .font(.title)
                .foregroundStyle(.yellow)
                .bold()
            Text(vm.movieSelected.title)
                .font(.title)
                .foregroundStyle(.yellow)
                .bold()
            if let uiImage = vm.movieSelected.cardImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .onTapGesture {
                        showSheet.toggle()
                    }
            } else {
                // poner el error view de deadpool
            }
            Spacer()
            AppButton(title: "Restart") {
                vm.playersName = ["", ""]
                vm.viewState = .startView
            }
            
        }
        .overlay {
            VStack {
                Text("Random movie . . .")
                    .bold()
                    .font(.title)
                    .foregroundStyle(.yellow)
            }
            .onAppear {
                print("loading view")
            }
            .appBackground()
            .opacity(vm.showLoadingView ? 1 : 0 )
            
        }
        .appBackground()
        .padding(.horizontal, 12)
        .sheet(isPresented: $showSheet, content: {
            DetailView()
        })
    }
}

#Preview {
    MovieSelectionView()
        .environment(MovieFlickViewModel())
}
