//
//  PlayersView.swift
//  MovieFlick
//
//  Created by Alex  on 16/8/24.
//

import SwiftUI

struct PlayersView: View {

    @State var textExample = ["", ""]
    var addPlayerText: String {
        if textExample.count < 4 {
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
            ForEach(textExample.indices, id: \.self) { index in
                HStack{
                    ZStack {
                        ButtonComponent(title: "", action: {}, color: Color.green)
                        TextField("Player \(index + 1)", text: $textExample[index])
                            .font(.title)
                            .bold()
                            .multilineTextAlignment(.center)
                            .frame(width: 200)
                    }
                    if textExample.count > 2 {
                        ButtonComponent(title: "-",
                                        action: {
                            textExample.remove(at: index)
                        },
                                        color: .red)
                        .frame(width: 50)
                    }
                }
            }
            ButtonComponent(title: addPlayerText,
                            action: {
                                if textExample.count < 4 {
                                    textExample.append("")
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
