import SwiftUI

struct FilterView: View {
    @Environment(MovieFlickViewModel.self) var vm
    
    var body: some View {
        VStack {
            Text("FILTERS")
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topLeading) {
            BackButtonComponent {
                vm.viewState = .chooseTypeView
            }
            .padding(.leading, 24)
        }
        .appBackground(gradientOpacity: 0.5)
    }
}

#Preview {
    FilterView()
        .environment(MovieFlickViewModel())
}
