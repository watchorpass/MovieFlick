import SwiftUI

struct FilterView: View {
    @Environment(MovieFlickViewModel.self) var vm
    let selectedType: String = "Movies"
    
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
            VStack(spacing: 20){
                AppButton(title: "Popular") {
                    vm.sortType = .popularity
                    vm.viewState = .genreView
                }
                AppButton(title: "Top rated") {
                    vm.sortType = .voteAverage
                    vm.viewState = .genreView
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appBackground()
    }
}

#Preview {
    FilterView()
}
