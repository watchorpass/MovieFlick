//
//  MovieFlickApp.swift
//  MovieFlick
//
//  Created by Alberto Alegre Bravo on 9/8/24.
//

import SwiftUI

@main
struct MovieFlickApp: App {
    @State var viewModel = MovieFlickViewModel()
    
    var body: some Scene {
        WindowGroup {
            CardStackView()
                .environment(viewModel)
        }
    }
}
