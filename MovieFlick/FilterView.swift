import SwiftUI

struct FilterView: View {
    @Environment(MovieFlickViewModel.self) var vm
    let selectedType: String = "Filters"
    
    var body: some View {
        VStack {
            Text(selectedType.uppercased())
                .font(.title)
                .bold()
                .foregroundStyle(.white)
            Spacer()
            Text("Select which list you want to see")
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
        .appBackground()
    }
}

#Preview {
    FilterView()
        .environment(MovieFlickViewModel())
}
