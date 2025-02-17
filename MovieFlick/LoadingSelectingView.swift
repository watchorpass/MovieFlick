import SwiftUI

struct LoadingSelectingView: View {
    @Environment(MovieFlickViewModel.self) var vm
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            AnimatedLogo()
            Text("**The MovieFlick team is on it!** 🍿 Spinning the reel to pick the perfect movie for you… Hang tight, quality cinema takes time! 🎬😄")
                .font(.title2)
                .foregroundStyle(.white)
                .padding()
                .multilineTextAlignment(.center)
            LoadingProgressView()
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appBackground(gradientOpacity: 0.5)
    }
}

struct LoadingProgressView: View {
    @State private var progress = 0.0
    let duration: Double = 4.2
    let updateInterval = 0.0083
    
    let timer = Timer.publish(every: 0.0083, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            ProgressView(value: progress, total: 1.0)
                .tint(.customPink.opacity(0.7))
                .progressViewStyle(LinearProgressViewStyle())
                .onReceive(timer) { _ in
                    if progress < 1.0 {
                        let increment = (updateInterval / duration)
                        progress = min(progress + increment, 1.0)
                    }
                }
        }
        .padding()
    }
}

#Preview {
    LoadingSelectingView()
        .environment(MovieFlickViewModel())
}
