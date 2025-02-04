import SwiftUI

extension Image {
    func aspectFill() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
