import SwiftUI

struct SettingsView: View {
    @Environment(MovieFlickViewModel.self) var vm
    @Environment(\.dismiss) var dismiss
    @State private var isExpanded = false
    
    var body: some View {
        @Bindable var bvm = vm
        
        ScrollView {
            VStack(spacing: 20) {
                Text("⚙️ Settings")
                    .font(.largeTitle)
                    .padding(.top)
                DisclosureGroup("Platforms allowed", isExpanded: $isExpanded) {
                    VStack {
                        ForEach(Provider.avaibleProviders, id: \.self) { provider in
                            Toggle("\(provider)", isOn: Binding(get: {
                                vm.isProviderSelected(provider: provider)
                            }, set: { isOn in
                                vm.toggleProvider(provider: provider)
                            }))
                            .padding(.horizontal)
                            
                        }
                    }
                }
                .tint(.primary)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial))
                .padding()
                Spacer()
                Text("Restart tips")
                Text("`Made with ♡ by Alberto, Alex, Fran M., and Fran O.`")
                    .font(.caption)
            }
        }
        .overlay(alignment: .topTrailing) {
            Button{
                dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundStyle(.regularMaterial)
            }
            .padding(5)
            
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
