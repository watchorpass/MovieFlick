import SwiftUI

struct AnimatedLogo: View {
    @State private var isAnimating = false
    
    var body: some View {
        Image(.rebrandingMovieFlick)
            .resizable()
            .scaledToFit()
            .padding()
            .rotationEffect(.degrees(isAnimating ? 2 : -2))
            .animation(
                Animation.easeInOut(duration: 1.2)
                    .repeatForever(autoreverses: true),
                value: isAnimating
            )
            .onAppear {
                isAnimating = true
            }
    }
}

#Preview {
    AnimatedLogo()
        .appBackground()
}
