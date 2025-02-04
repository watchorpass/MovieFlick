import SwiftUI
import TipKit

@main
struct MovieFlickApp: App {
    @State var viewModel = MovieFlickViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainAppView()
                .environment(viewModel)
                .task {
                    try? Tips.configure([
                        .datastoreLocation(.applicationDefault)])
                }
        }
    }
}
