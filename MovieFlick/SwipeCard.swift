//
//  SwipeCard.swift
//  MovieFlick
//
//  Created by Alberto Alegre Bravo on 25/8/24.
//

import SwiftUI

struct NewCard: View {
    @Environment(MovieFlickViewModel.self) var viewModel

    @State private var xOffset: CGFloat = 0
    @State private var degrees: Double = 0
    
    let movie: Movie
    
    var body: some View {
        ZStack(alignment: .top) {
            if let image = movie.cardImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .overlay(alignment: .bottomTrailing) {
                        Image(systemName: "info.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                            .foregroundStyle(.yellow)
                            .padding(16)
                    }
            }
            SwipeActionIndicationView(xOffset: $xOffset, screenCutoff: screenCutoff)
                .frame(width: cardWidth)
            
        }
        .frame(width: cardWidth, height: cardHeight)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .offset(x: xOffset)
        .rotationEffect(.degrees(degrees))
        .animation(.snappy, value: xOffset)
        .gesture(
            DragGesture()
                .onChanged(onDragChange)
                .onEnded(onDragEnded)
        )
    }
}

extension NewCard {
    func returnToCenter() {
        xOffset = 0
        degrees = 0
    }
    
    func swipeRight() {
        withAnimation {
            xOffset = 500
            degrees = 12
        } completion: {
            viewModel.swipeCount -= 1
        }
    }
    
    func swipeLeft() {
        withAnimation {
            xOffset = -500
            degrees = -12
        } completion: {
            viewModel.removeFromResultMovies(movie: movie)
            viewModel.swipeCount -= 1
        }
    }
}

extension NewCard {
    func onDragChange(_ value: _ChangedGesture<DragGesture>.Value) {
        xOffset = value.translation.width
        degrees = Double(value.translation.width / 25)
    }
    
    func onDragEnded(_ value: _ChangedGesture<DragGesture>.Value) {
        let width = value.translation.width
        
        if abs(width) <= abs(screenCutoff) {
            returnToCenter()
            return
        }
        
        if width >= screenCutoff {
            swipeRight()
        } else {
            swipeLeft()
        }
    }
}

extension NewCard {
    var screenCutoff: CGFloat {
        (UIScreen.main.bounds.width / 2) * 0.8
    }
    
    var cardWidth: CGFloat {
        UIScreen.main.bounds.width - 20
    }
    
    var cardHeight: CGFloat {
        UIScreen.main.bounds.height / 1.45
    }
}

struct SwipeActionIndicationView: View {
    @Binding var xOffset: CGFloat
    let screenCutoff: CGFloat
    
    var body: some View {
        HStack {
            Text("YES")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundStyle(.green)
                .overlay {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.green, lineWidth: 2)
                        .frame(width: 100, height: 48)
                }
                .rotationEffect(.degrees(-45))
                .opacity(Double(xOffset / screenCutoff))
            
            Spacer()
            
            Text("NO")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundStyle(.red)
                .overlay {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.red, lineWidth: 2)
                        .frame(width: 100, height: 48)
                }
                .rotationEffect(.degrees(45))
                .opacity(Double(xOffset / screenCutoff) * -1)
        }
        .padding(40)
    }
}

#Preview {
    //SwipeActionIndicationView(xOffset: .constant(20), screenCutoff: 500)
    NewCard(movie: .previewMovie)
        .environment(MovieFlickViewModel())
}
