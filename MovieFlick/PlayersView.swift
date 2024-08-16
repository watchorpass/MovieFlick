//
//  PlayersView.swift
//  MovieFlick
//
//  Created by Alex  on 16/8/24.
//

import SwiftUI

struct PlayersView: View {
    var body: some View {
        VStack {
            Text("Create your players")
            Spacer()
            ButtonComponent(title: "Add new player", action: {}, color: Color.green)
            Spacer()
            ButtonComponent(title: "Continue", action: { })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.3), Color.black.opacity(0.8)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }
    }
}

#Preview {
    PlayersView()
}
