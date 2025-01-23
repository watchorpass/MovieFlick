//
//  AboutLegalView.swift
//  MovieFlick
//
//  Created by Fran Malo on 9/10/24.
//

import SwiftUI

struct AboutLegalView: View {
    @Environment(MovieFlickViewModel.self) var vm

    var body: some View {
        ScrollView(showsIndicators: false) {
            Text("Legal + About us")
                .font(.title)
                .bold()
                .foregroundStyle(.white)
                .padding(.top, 48)
            
            Text("legal_policy_text")
                .font(.system(size: 13))
                .padding()
                .frame(maxWidth: 400)
                .background(.white.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .multilineTextAlignment(.center)
            Text("Proudly developed by [Alberto Alegre](https://github.com/Bitos88), [Alex Ma](https://github.com/alexmaxu), [Fran Malo](https://github.com/franmu94) and [Fran Ochoa](https://github.com/fran-6co)")
                .font(.system(size: 18, weight: .regular, design: .monospaced))
                .foregroundStyle(.black)
                .padding()
                .frame(maxWidth: 400)
                .background(.white.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .multilineTextAlignment(.center)
                .padding(.top, 32)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal)
        .appBackground(gradientOpacity: 0.5)
        .overlay (alignment: .topTrailing){
            Button {
                vm.viewState = .startView
            } label: {
                Image(systemName: "x.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                    .foregroundStyle(.white)
            }
            .padding()
            .buttonStyle(PlainButtonStyle())

        }
    }
}

#Preview {
    AboutLegalView()
        .environment(MovieFlickViewModel())
}
