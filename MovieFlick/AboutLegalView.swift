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
        VStack {
            Text("About")
                .font(.title)
                .bold()
                .foregroundStyle(.white)
            
            Text("Third Party Intellectual Property Movies metadata is provided by TMDb, the Movie Database. For more information, visit www.themoviedb.org. This is an external service and therefore we are not responsible for the information it provides and cannot guarantee availability. We do not assume any responsibility for the content, privacy policies, or practices of any third party web sites or services.")
                .padding()
                .frame(maxWidth: 400)
                .background(.white.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .multilineTextAlignment(.center)
            Text("Prouded devolopep by [Alberto Alegre](https://github.com/Bitos88),[Alex Ma](https://github.com/alexmaxu), [Fran Malo](https://github.com/franmu94) and [Fran Ochoa](https://github.com/fran-6co)")
                .font(.system(size: 20, weight: .regular, design: .monospaced))
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
                Image(systemName: "x.square")
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
