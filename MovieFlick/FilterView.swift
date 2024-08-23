import SwiftUI

struct FilterView: View {
    let selectedType: String
    
    var body: some View {
        VStack {
            Text(selectedType.uppercased())
                .font(.title)
                .bold()
                .foregroundStyle(.yellow)
            Spacer()
            Text("Select which list you want to see")
                .foregroundStyle(.yellow)
                .padding(.bottom, 30)
            AppButton(title: "Popular", action: {})
                .padding(.bottom, 20)
            AppButton(title: "Top rated", action: {})
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appBackground()
    }
}

#Preview {
    FilterView(selectedType: "Movies")
}
