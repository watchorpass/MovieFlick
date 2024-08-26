//
//  StartView.swift
//  MovieFlick
//
//  Created by Alex  on 16/8/24.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(.logoLetra)
                .resizable()
                .scaledToFit()
                .padding()
            Spacer()
            AppButton(title: "Start", action: {})
        }
        .padding(.bottom, 100)
        .appBackground(gradientOpacity: 0.5)
    }
}

#Preview {
    StartView()
}
