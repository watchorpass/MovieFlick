import SwiftUI

struct SettingsView: View {
    @Environment(MovieFlickViewModel.self) var vm
    
    var body: some View {
        VStack(spacing: 20) {
            Text("⚙️ Settings")
                .font(.largeTitle)
            DisclosureGroup("Platforms allowed") {
                List {
                    ForEach(Provider.allCases, id: \.self) { platform in
                        Text(platform.description)
                    }
                }
            }
            Text("`Made with ♡ by Alberto, Alex, Fran M., and Fran O.`")
                .font(.caption)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.purple.opacity(0.8)
                .ignoresSafeArea()
        }
    }
}

#Preview("main") {
    MainAppView()
        .environment(MovieFlickViewModel())
}
#Preview("just settings") {
    SettingsView()
        .environment(MovieFlickViewModel())
}
