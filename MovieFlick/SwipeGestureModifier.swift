import SwiftUI

struct SwipeGestureModifier: ViewModifier {
    @Binding var offset: CGSize
    @Binding var color: Color
    @Binding var buttonOpacity: Bool
    
    func body(content: Content) -> some View {
        content
            .offset(x: offset.width, y: offset.height * 0.4)
            .rotationEffect(.degrees(Double(offset.width / 40)))
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                        withAnimation {
                            changeColor(width: offset.width)
                        }
                    }
                    .onEnded { _ in
                        withAnimation {
                            swipeCard(width: offset.width)
                            changeColor(width: offset.width)
                        }
                    }
            )
    }
    
    private func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150):
            offset = CGSize(width: -500, height: 0)
        case 150...500:
            offset = CGSize(width: 500, height: 0)
        default:
            offset = .zero
        }
    }
    
    private func changeColor(width: CGFloat) {
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
