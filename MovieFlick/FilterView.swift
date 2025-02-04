import SwiftUI

struct FilterView: View {
    @Environment(MovieFlickViewModel.self) var vm
    
    var body: some View {
        VStack {
            Text("Filters")
                .font(.title)
                .bold()
                .foregroundStyle(.white)
            Spacer()
            Text("Choose your priority")
                .foregroundStyle(.white)
                .padding(.bottom, 30)
            VStack(spacing: 20){
                AppButton(title: "Popular", color: .gray) {
                    vm.sortType = .popularity
                    vm.viewState = .providerView
                }
                AppButton(title: "Top rated", color: .gray) {
                    vm.sortType = .voteAverage
                    vm.viewState = .providerView
                }
            }
            .padding()
            Spacer()
        }
        .padding(.top, 48)
        .backButton(previousViewState: .chooseTypeView)
        .appBackground(gradientOpacity: 0.5)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    FilterView()
        .environment(MovieFlickViewModel())
}
