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
    @State private var showDetail = false
    
    var imageOffset: CGFloat
    var imageURL: URL?
    
    var positiveAction: () -> Void
    var negativeAction: () -> Void
    
    var body: some View {
        VStack {
            Text("Player One")
                .font(.title)
                .bold()
                .foregroundStyle(Color.white)
                .padding(.top, 15)
            ZStack {
                AsyncImage(url: imageURL) { img in
                    img
                        .aspectFill()
                } placeholder: {
                    Image(systemName: "popcorn")
                        .aspectFill()
                }
                .posterImgModifiers(color: color)
                .offset(x: imageOffset * -2, y: imageOffset * -2)
            }
            .offset(x: offset.width, y: offset.height * 0.4)
            .rotationEffect(.degrees(Double(offset.width / 40)))
            .swipeGestureModifier(offset: $offset, color: $color, buttonOpacity: $buttonOpacity)
            
            Spacer()
            buttonsView
            Spacer()
        }
        .sheet(isPresented: $showDetail) {
            Rectangle()
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
                
                negativeAction()
            } label: {
                Image(systemName: "xmark")
                    .fontWeight(.heavy)
                    .foregroundStyle(Color.red)
                    .background {
                        Circle()
                            .fill(.white.opacity(0.7))
                            .frame(width: 48, height: 48)
                            .shadow(color: .white, radius: 4)
                    }
            }
            
            Button {
                withAnimation {
                    changeColor(width: offset.width)
                    offset = CGSize(width: 500, height: 0)
                    buttonOpacity.toggle()
                }
                
                positiveAction()
            } label: {
                Image(systemName: "heart.fill")
                    .fontWeight(.heavy)
                    .foregroundStyle(Color.green)
                    .background {
                        Circle()
                            .fill(.white.opacity(0.7))
                            .frame(width: 48, height: 48)
                            .shadow(color: .white, radius: 4)
                    }
            }
        }
        .opacity(buttonOpacity ? 1 : 0)
        .padding(.top, 20)
    }
    
    func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150):
            offset = CGSize(width: -500, height: 0)
            negativeAction()
        case 150...500:
            offset = CGSize(width: 500, height: 0)
            positiveAction()
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
    NavigationStack {
        SwipeCardComponent(imageOffset: .zero, imageURL: URL(string: "https://image.tmdb.org/t/p/w500/rweIrveL43TaxUN0akQEaAXL6x0.jpg")!) {
            
        } negativeAction: {
            
        }
            .appBackground()
    }
}
