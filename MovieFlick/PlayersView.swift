//
//  PlayersView.swift
//  MovieFlick
//
//  Created by Alex  on 16/8/24.
//

import SwiftUI

struct PlayersView: View {

    @State var textExample = ["", ""]

    var body: some View {
        VStack {
            Text("Create your players")
                .font(.title)
                .bold()
                .foregroundStyle(Color.yellow)

            Spacer()
            ForEach (0..<textExample.count) { index in
                ZStack {
                    ButtonComponent(title: "", action: {}, color: Color.green)
                    TextField("Player 1", text: $textExample[index])
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
