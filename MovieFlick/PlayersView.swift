//
//  PlayersView.swift
//  MovieFlick
//
//  Created by Alex  on 16/8/24.
//

import SwiftUI

struct PlayersView: View {

    @State var textExample = ["Player 1", "Player 2"]

    var body: some View {
        VStack {
            Text("Create your players")
                .font(.title)
                .bold()
                .foregroundStyle(Color.yellow)

            Spacer()
            ForEach ($textExample, id: \.self) { player in
                ZStack {
                    ButtonComponent(title: "", action: {}, color: Color.green)
                    TextField("Player 1", text: player)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                        .frame(width: 200)
                }
            }
            ButtonComponent(title: "Add new player +", action: {textExample.append("")}, color: Color.yellow)
            Spacer()
            ButtonComponent(title: "Continue", action: {})
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appBackground()
    }
}

#Preview {
    PlayersView()
}
