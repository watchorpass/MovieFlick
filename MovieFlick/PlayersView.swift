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
                    ZStack {
                        ButtonComponent(title: "", action: {}, color: Color.green)
                        TextField("Player \(index + 1)", text: $PlayersName[index])
                            .font(.title)
                            .bold()
                            .multilineTextAlignment(.center)
                            .frame(width: 200)
                    }
                    if PlayersName.count > 2 {
                        ButtonComponent(title: "-",
                                        action: {
                            PlayersName.remove(at: index)
                        },
                                        color: .red)
                        .frame(width: 50)
                    }
                }
            }
            ButtonComponent(title: addPlayerText,
                            action: {
                                if PlayersName.count < 4 {
                                    PlayersName.append("")
                                }
                            },
                            color: Color.yellow)
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
