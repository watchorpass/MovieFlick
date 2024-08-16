//
//  Image+Extension.swift
//  MovieFlick
//
//  Created by Alberto Alegre Bravo on 15/8/24.
//

import SwiftUI

extension Image {
    func aspectFill() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
