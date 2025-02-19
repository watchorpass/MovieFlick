import SwiftUI

struct MovieSelectionView: View {
    @Environment(MovieFlickViewModel.self) var vm
    @State var showDetail = false
    
    var body: some View {
        VStack {
            Text("Selected movie is: ")
                .font(.title)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .bold()
                .padding(.top, 50)
            if let selectedMovie = vm.selectedMovie {
                if let uiImage = selectedMovie.cardImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(alignment: .bottomTrailing) {
                            Image(systemName: "info.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                                .foregroundStyle(.white)
                                .padding(16)
                                .onTapGesture {
                                    vm.selectedMovie = selectedMovie
                                    showDetail.toggle()
                                }
                        }
                } else {
                    CustomErrorView(alertTitle: "Image can not be loaded. Try again please.",
                                    alertMessage: vm.errorMsg) {
                        Task {
                            await vm.fetchContent()
                        }
                    }
                    .padding(.bottom, 68)
                }
            }
            Spacer()
            AppButton(title: "Restart", color: .gray) {
                vm.resetGame()
                vm.viewState = .startView
            }
            .padding()
        }
        .sheet(isPresented: $showDetail) {
            if let movie = vm.selectedMovie {
                DetailView(movie: movie)
            }
        }
        .padding(.horizontal, 12)
        .appBackground(gradientOpacity: 0.5)
        .overlay {
            LoadingSelectingView()
                .opacity(vm.showLoadingView ? 1 : 0)
        }
    }
}

#Preview {
    MovieSelectionView()
        .environment(MovieFlickViewModel())
}
