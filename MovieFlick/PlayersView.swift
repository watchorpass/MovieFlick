//
//  PlayersView.swift
//  MovieFlick
//
//  Created by Alex  on 16/8/24.
//

import SwiftUI

struct PlayersView: View {

    @State var PlayersName = ["", ""]
    var addPlayerText: String {
        if PlayersName.count < 4 {
            return "Add new player +"
        } else {
            return "Max. 4 players"
        }
    }

    var body: some View {
        VStack {
            Text("Create your players")
                .font(.title)
                .bold()
                .foregroundStyle(Color.yellow)
            Spacer()
            ForEach(PlayersName.indices, id: \.self) { index in
                HStack{
                    PlayerTextField(backgroundText: "Player \(index + 1)", text: $PlayersName[index], color: .green)
                    if PlayersName.count > 2 {
                        ButtonComponent(title: "-",
                                        color: .red, action: {
                            PlayersName.remove(at: index)
                        })
                        .frame(width: 50)
                    }
                }
            }
            ButtonComponent(title: addPlayerText,
                            color: Color.yellow, action: {
                if PlayersName.count < 4 {
                    PlayersName.append("")
                }
            })
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
