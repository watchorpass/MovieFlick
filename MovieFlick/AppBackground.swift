import SwiftUI

struct AppBackground: ViewModifier {
    var gradientOpacity: Double = 0.7
    func body(content: Content) -> some View {
        content
            .background {
                ZStack {
                    Color.black
                    LinearGradient(
                        gradient: Gradient(colors: [Color.purple.opacity(gradientOpacity), Color.purple.opacity(gradientOpacity),  Color.black.opacity(gradientOpacity)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                }
                .ignoresSafeArea()
            }
    }
}
