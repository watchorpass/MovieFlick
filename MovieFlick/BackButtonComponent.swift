import SwiftUI

struct BackButtonComponent: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "chevron.left")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    BackButtonComponent() {}
}
