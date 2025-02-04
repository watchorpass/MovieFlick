import SwiftUI

struct PlayerTextField: View {
    var backgroundText: LocalizedStringKey
    @Binding var text: String

    var body: some View {
        TextField(backgroundText, text: $text, prompt: Text(backgroundText).foregroundStyle(.white.opacity(0.5)))
            .foregroundStyle(.white)
            .accentColor(.white)
            .multilineTextAlignment(.center)
            .autocorrectionDisabled()
            .font(.title)
            .bold()
            .foregroundColor(.primary)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(.white.opacity(0.3))
            .cornerRadius(10)
    }
}

#Preview {
    PlayerTextField(backgroundText: "Text Background", text: .constant(String()))
        .appBackground()
}
