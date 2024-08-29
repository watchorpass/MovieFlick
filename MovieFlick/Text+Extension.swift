import SwiftUI

//public let typography = "Lonely Cake"
//public let typography = "Intensa Fuente"
public let typography = "Sparky Stones"

extension Text {
    func largeTitle() -> some View {
        self
            .font(.custom(typography, size: 50, relativeTo: .title))
            .foregroundStyle(.yellow)
            .multilineTextAlignment(.center)
    }
    
    func body() -> some View {
        self
            .font(.custom(typography, size: 18, relativeTo: .body))
            .foregroundStyle(.yellow)
    }
    
    func smallTitle() -> some View {
        self
            .font(.custom(typography, size: 28, relativeTo: .title3))
            .fontWeight(.regular)
            .foregroundStyle(.yellow)
    }
}
