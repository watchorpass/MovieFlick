import SwiftUI

struct MainAppView: View {
    @Environment(MovieFlickViewModel.self) var vm
    
    var body: some View {
        Group {
            switch vm.viewState {
            case .startView:
                StartView()
            case .playersView:
                PlayersView()
            case .chooseTypeView:
                ChooseTypeView()
            case .filterView:
                FilterView()
            case .genreView:
                GenreView()
            case .swipeView:
                CardStackView()
            case .playerTwoView:
                NextPlayerView()
            case .resultView:
                Text("ResultView")
            }
        }
        .animation(.spring, value: vm.viewState)
    }
}

#Preview {
    MainAppView()
        .environment(MovieFlickViewModel())
}
