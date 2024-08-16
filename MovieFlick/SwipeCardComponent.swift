//
//  SwipeCardComponent.swift
//  MovieFlick
//
//  Created by Alberto Alegre Bravo on 15/8/24.
//

import SwiftUI

struct SwipeCardComponent: View {
    @State private var offset = CGSize.zero
    @State private var color: Color = .clear
    @State private var buttonOpacity = true
    var imageURL: URL?
    
    var body: some View {
        VStack {
            ZStack {
                AsyncImage(url: URL(string: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/aQnbNiadeGzGSjWLaXyeNxpAUIx.jpg")!) { img in
                    img
                        .aspectFill()
                } placeholder: {
                    Image(systemName: "popcorn")
                        .aspectFill()
                }
                .posterImgModifiers(color: color)
            }
            .offset(x: offset.width, y: offset.height * 0.4)
            .rotationEffect(.degrees(Double(offset.width / 40)))
            .swipeGestureModifier(offset: $offset, color: $color, buttonOpacity: $buttonOpacity)
            
            buttonsView
        }
    }
    
    var buttonsView: some View {
        HStack(spacing: 100) {
            Button {
                withAnimation {
                    changeColor(width: offset.width)
                    let newOffset = CGSize(width: -500, height: 0)
                    swipeCard(width: newOffset.width)
                    buttonOpacity.toggle()
                }
            } label: {
                Image(systemName: "xmark")
                    .foregroundStyle(Color.white)
                    .font(.title)
                    .padding()
                    .background(Color.red)
                    .clipShape(Circle())
            }
            
            Button {
                withAnimation {
                    changeColor(width: offset.width)
                    offset = CGSize(width: 500, height: 0)
                    buttonOpacity.toggle()
                }
            } label: {
                Image(systemName: "arrowshape.turn.up.right")
                    .foregroundStyle(Color.white)
                    .font(.title)
                    .padding()
                    .background(Color.green)
                    .clipShape(Circle())
            }
        }
        .opacity(buttonOpacity ? 1 : 0)
        .padding(.top, 60)
    }
    
    func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150):
            offset = CGSize(width: -500, height: 0)
        case 150...500:
            offset = CGSize(width: 500, height: 0)
        default:
            offset = .zero
        }
    }
    
    func changeColor(width: CGFloat) {
        switch width {
        case -500...(-20):
            color = .red.opacity(0.8)
        case 20...500:
            color = .green.opacity(0.8)
        default:
            color = .clear
        }
    }
}

#Preview {
    SwipeCardComponent()
}
