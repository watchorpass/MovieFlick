import SwiftUI

struct TextLegalModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: 400)
            .background(.white.opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .multilineTextAlignment(.center)
    }
}
