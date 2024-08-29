//
//  Text&TypographyExampleView.swift
//  MovieFlick
//
//  Created by Fran Ochoa on 29/8/24.
//

import SwiftUI

struct Text_TypographyExampleView: View {
    var body: some View {
        VStack(spacing: 80) {
            Text("\(typography) title EXAMPLE")
                .largeTitle()
            Text("Small title – UPPERCASE")
                .smallTitle()
            Text("This text should be the body of the app text. Here is another line to make the text multilined and check the visuals. Lorem ipsum.")
                .body()
            AppButton(title: "Button", action: {})
        }
        .padding()
        .appBackground(gradientOpacity: 0.5)
    }
}

#Preview {
    Text_TypographyExampleView()
}
