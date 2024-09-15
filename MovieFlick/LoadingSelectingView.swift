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
            GifImage(name: "movieLoading")
                .scaledToFit()
                .frame(width: 200)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appBackground()
    }
}

#Preview {
    LoadingSelectingView()
        .environment(MovieFlickViewModel())
}
