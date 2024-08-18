//
//  ChooseTypeView.swift
//  MovieFlick
//
//  Created by Alex  on 18/8/24.
//

import SwiftUI

struct ChooseTypeView: View {
    var body: some View {
        VStack {
            Text("What to see")
                .font(.title)
                .bold()
            Spacer()
            GridCellComponent(title: "Films", cellSize: 300, image: Image("Interestellar"), action: {})
                .padding()
            GridCellComponent(title: "Films", cellSize: 300, image: Image("TheLastOfUs"), action: {})
                .padding()
            Spacer()
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
    ChooseTypeView()
}
