//
//  PosterImgModfier.swift
//  MovieFlick
//
//  Created by Alberto Alegre Bravo on 15/8/24.
//

import SwiftUI

struct PosterImgModifiers: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .frame(width: 350)
            .border(color, width: 6.0)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .foregroundStyle(Color.black.opacity(0.9))
            .shadow(radius: 4)
    }
}
