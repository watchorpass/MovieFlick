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
            ButtonComponent(title: "Start", action: {
                print("Start pressed")
            })
        }
        .padding(.bottom, 100)
        .background {
            Image(.startView)
                .opacity(0.7)
        }
    }
}

#Preview {
    StartView()
}
