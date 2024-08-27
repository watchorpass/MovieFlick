import SwiftUI

extension Text {
    func title() -> some View {
        self
            .font(.title)
            .fontWeight(.medium)
            .foregroundStyle(.yellow)
    }
    
    func text() -> some View {
        self
            .font(.body)
            .fontWeight(.regular)
            .foregroundStyle(.yellow)
    }
}
