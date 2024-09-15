

import SwiftUI

enum ViewState {
    case startView
    case playersView
    case chooseTypeView
    case filterView
    case providerView
    case genreView
    case swipeView
    case playerTwoView
    case resultView
    case movieSelection
}
enum SelectedType:  String {
    case movie = "MOVIE"
    case serie = "SERIE"
}

@Observable
final class MovieFlickViewModel {
    let interactor: MovieListInteractorProtocol
    var resultMovies: [Movie] = []
    var moviesWithCard: [Movie] = []
    var playersName: [String] = ["", ""]
    
    var selectedMovie: Movie?
    var providerList: [Provider]? = nil
    var swipeCount: Int = 0
    
    var viewState: ViewState = .startView
    var sortType: SortType = .popularity
    var selectedGenres: [Genre] = [.all]
    var selectedType: SelectedType = .movie
    var selectedProviders: [Provider] = []
    
    var showError = false
    var errorMsg = ""
    
    let swipeTip = SwipeTip()
    let genreTip = GenreTip()
    let chooseOneTip = ChooseOneTip()
    
    var showLoadingView = true
    
    init(interactor: MovieListInteractorProtocol = MovieListInteractor()) {
        self.interactor = interactor
    }
    
    func randomMovie() {
        if let movieWinner = resultMovies.randomElement() {
            selectedMovie = movieWinner
        }
        Task {
            try? await Task.sleep(nanoseconds: 5_000_000_000)
            showLoadingView.toggle()
        }
    }
    
    func restartCount() {
        swipeCount = moviesWithCard.count
    }
    
    func fetchMovies() async {
        do {
            let movies = try await interactor.getMovies(isAdult: true, includesVideo: nil, page: 1, sortBy: .popularity, releaseYear: nil, dateGreaterThan: nil, dateLessThan: nil, voteGreaterThan: nil, voteLessThan: nil, region: "ES", providers: selectedProviders, genres: selectedGenres, monetizationTypes: [.flatrate])
            
            moviesWithCard = try await interactor.loadCardImages(for: movies).reversed()
            resultMovies = moviesWithCard
            swipeCount = moviesWithCard.count
        } catch {
            showError.toggle()
            errorMsg = "Check your internet connection and try again"
        }
    }
    
    func fetchSeries() async {
        do {
            let movies = try await interactor.getSeries(isAdult: true, includesVideo: nil, page: 1, sortBy: .popularity, releaseYear: nil, dateGreaterThan: nil, dateLessThan: nil, voteGreaterThan: nil, voteLessThan: nil, region: "ES", providers: selectedProviders, genres: selectedGenres, monetizationTypes: [.flatrate])
            
            moviesWithCard = try await interactor.loadCardImages(for: movies).reversed()
            resultMovies = moviesWithCard
            swipeCount = moviesWithCard.count
        } catch {
            showError.toggle()
            errorMsg = "Check your internet connection and try again"
        }
    }
    
    func fetchContent() async {
        switch selectedType {
            case .movie:
                await fetchMovies()
            case .serie:
                await fetchSeries()
        }
    }
    func removeCard(_ movie: Movie) {
        guard let index = moviesWithCard.firstIndex(where: {$0.id == movie.id }) else { return }
        moviesWithCard.remove(at: index)
    }
    
    func removeFromResultMovies(movie: Movie) {
        guard let index = resultMovies.firstIndex(where: {$0.id == movie.id}) else { return }
        resultMovies.remove(at: index)
    }
    
    func addGenre(genre: Genre) {
        if genre == .all {
            selectedGenres = Genre.allCases
        } else {
            if let index = selectedGenres.firstIndex(of: .all) {
                selectedGenres.remove(at: index)
            }
            if selectedGenres.contains(genre) {
                selectedGenres.removeAll { $0 == genre }
            } else {
                selectedGenres.append(genre)
            }
        }
    }
    
    func movieSelected(_ index: Int) -> Movie {
        return moviesWithCard[index]
    }
    
    func playersWithoutName() -> Bool {
        playersName.contains("")
    }
    
    func addprovider(provider: Provider) {
        if selectedProviders.contains(provider) {
            selectedProviders.removeAll { $0 == provider }
        } else {
            selectedProviders.append(provider)
        }
    }
    
    
    func isProviderSelected(provider: Provider) -> Bool {
        return providerList?.contains(provider) ?? false
    }
    
    func toggleProvider(provider: Provider) {
        if let index = providerList?.firstIndex(of: provider) {
            providerList?.remove(at: index)
        } else {
            providerList?.append(provider)
        }
    }
}
