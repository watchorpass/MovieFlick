import SwiftUI

struct MainAppView: View {
    @Environment(MovieFlickViewModel.self) var vm
    
    var body: some View {
        Group {
            switch vm.viewState {
            case .startView:
                StartView()
            case .aboutLegalView:
                AboutLegalView()
            case .playersView:
                PlayersView()
            case .chooseTypeView:
                ChooseTypeView()
            case .filterView:
                FilterView()
            case .genreView:
                GenreView()
            case .cardStackView:
                CardStackView()
            case .resultView:
                ResultsView()
            case .movieSelection:
                MovieSelectionView()
            case .providerView:
                ProvidersView()
            }
        }
        .background(.black)
        .animation(.spring, value: vm.viewState)
    }
}

#Preview {
    MainAppView()
        .environment(MovieFlickViewModel())
}
