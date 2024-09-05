import SwiftUI

struct FilterView: View {
    @Environment(MovieFlickViewModel.self) var vm
    let selectedType: String = "Filters"
    
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
                    vm.viewState = .providerView
                }
                AppButton(title: "Top rated") {
                    vm.sortType = .voteAverage
                    vm.viewState = .providerView
                }
            }
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
        .appBackground()
    }
}

#Preview {
    FilterView()
        .environment(MovieFlickViewModel())
}
