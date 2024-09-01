//
//  LoadingSelectingView.swift
//  MovieFlick
//
//  Created by Alex  on 1/9/24.
//

import SwiftUI

struct LoadingSelectingView: View {
    @Environment(MovieFlickViewModel.self) var vm
    
    var body: some View {
        VStack {
            Text("Selecting movie . . .")
                .bold()
                .font(.title)
                .foregroundStyle(.yellow)
            GifImage(name: "xdd")
                .frame(width: 200, height: 200)
        }
        .appBackground()
        .opacity(vm.showLoadingView ? 1 : 0 )
    }
}

#Preview {
    LoadingSelectingView()
        .environment(MovieFlickViewModel())
}
