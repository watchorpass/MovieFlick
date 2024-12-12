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
        ScrollView {
            Text("Legal + About us")
                .font(.title)
                .bold()
                .foregroundStyle(.white)
            
            Text("The movie metadata within this app is provided by a third-party service, The Movie Database (TMDb). For more information about TMDb, please visit www.themoviedb.org. We are not affiliated with TMDb, nor are we responsible for the accuracy, availability, or legality of the information they provide. TMDb is an independent service, and we do not endorse or control the content it supplies. This app does not intend to claim or imply ownership, endorsement, or association with any specific movies, studios, or other intellectual property referenced through TMDb metadata. All trademarks, movie titles, and associated media are the property of their respective owners. We disclaim any responsibility for potential copyright or trademark issues arising from the display of metadata provided by TMDb. Users should refer to TMDb and the rights holders of specific intellectual properties for any concerns regarding legal use. We further do not assume responsibility for the content, privacy policies, or practices of any third-party websites or services linked from this app.")
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
