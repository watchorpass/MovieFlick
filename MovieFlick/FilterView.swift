import SwiftUI

struct FilterView: View {
    @Environment(MovieFlickViewModel.self) var vm
    let selectedType: String = "Filters"
    
    var body: some View {
        VStack {
            Text(selectedType.uppercased())
                .largeTitle()
            Spacer()
            Text("Select which list you want to see")
                .body()
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
            .padding(30)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appBackground()
    }
}

#Preview {
    FilterView()
        .environment(MovieFlickViewModel())
}
