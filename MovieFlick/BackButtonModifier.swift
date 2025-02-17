import SwiftUI

struct BackButtonModifier: ViewModifier {
    @Environment(MovieFlickViewModel.self) var vm
    
    let viewState: ViewState
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .topLeading) {
                BackButtonComponent {
                    vm.viewState = viewState
                }
                .padding()
            }
    }
}
