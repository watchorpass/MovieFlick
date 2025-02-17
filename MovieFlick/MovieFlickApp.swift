import SwiftUI
import TipKit

@main
struct MovieFlickApp: App {
    @State var viewModel = MovieFlickViewModel()
    @State var playerViewModel = PlayerManager()
    
    var body: some Scene {
        WindowGroup {
            MainAppView()
                .environment(viewModel)
                .environment(playerViewModel)
                .task {
                    try? Tips.configure([
                        .datastoreLocation(.applicationDefault)])
                }
        }
    }
}
