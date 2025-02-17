import SwiftUI

enum ViewState {
    case startView
    case aboutLegalView
    case playersView
    case chooseTypeView
    case filterView
    case providerView
    case genreView
    case cardStackView
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
    let playerManager = PlayerManager()
    let providerRepository: ProviderRepositoryProtocol
    
    var resultMovies: [Movie] = []
    var moviesWithCard: [Movie] = []
    var moviesLeft: Int = 0
    var selectedMovie: Movie?
    var swipeCount: Int = 0
    var viewState: ViewState = .startView
    var sortType: SortType = .popularity
    var selectedGenres: [Genre] = []
    var selectedType: SelectedType = .movie
    var selectedProviders: [Provider] = []
    var showError = false
    var errorMsg: LocalizedStringKey = ""
    var showLoadingView = false
    private var timer: Timer?
    var noResults = false
    
    let swipeTip = SwipeTip()
    let genreTip = GenreTip()
    let chooseOneTip = ChooseOneTip()
    
    init(interactor: MovieListInteractorProtocol = MovieListInteractor(), provider: ProviderRepositoryProtocol = ProviderRepository()) {
        self.interactor = interactor
        self.providerRepository = provider
        loadProviders()
        moviesLeft = moviesWithCard.count
    }
    
    func startLoadingTimer() {
        defer {
            timer = nil
            timer?.invalidate()
        }
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            self.showLoadingView.toggle()
        }
    }
    
    func randomMovie() {
        if let movieWinner = resultMovies.randomElement() {
            selectedMovie = movieWinner
        }
        if resultMovies.count != 1 {
            showLoadingView.toggle()
            startLoadingTimer()
        }
    }
    
    func restartCount() {
        swipeCount = moviesWithCard.count
    }
    
    private func fetchMovies() async {
        let randomPage = Int.random(in: 1..<10)
        do {
            let movies = try await interactor.getMovies(page: randomPage, sortBy: .popularity, providers: selectedProviders, genres: selectedGenres, monetizationTypes: [.flatrate])
            moviesWithCard = try await interactor.loadCardImages(for: movies).reversed()
            if moviesWithCard.count < 2 {
                noResults = true
            }
            showError = false
            resultMovies = moviesWithCard
            swipeCount = moviesWithCard.count
            moviesLeft = moviesWithCard.count
        } catch {
            errorMsg = "We couldn’t load your movies, please try again later"
            showError = true
        }
    }
    
    private func fetchSeries() async {
        let randomPage = Int.random(in: 1..<10)
        do {
            let movies = try await interactor.getSeries(page: randomPage, sortBy: .popularity, providers: selectedProviders, genres: selectedGenres, monetizationTypes: [.flatrate])
            moviesWithCard = try await interactor.loadCardImages(for: movies).reversed()
            if moviesWithCard.count < 2 {
                noResults = true
            }
            showError = false
            resultMovies = moviesWithCard
            swipeCount = moviesWithCard.count
            moviesLeft = moviesWithCard.count
        } catch {
            errorMsg = "We couldn’t load your TV Series, please try again later"
            showError = true
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
    
    func removeFromResultMovies(movie: Movie) {
        guard let index = resultMovies.firstIndex(where: {$0.id == movie.id}) else { return }
        resultMovies.remove(at: index)
    }
    
    func addGenre(genre: Genre) {
        if genre == .all {
            selectedGenres = selectedGenres.contains(.all) ? [] : [.all]
        } else {
            selectedGenres.removeAll { $0 == .all }
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
    
    func addprovider(provider: Provider) {
        if selectedProviders.contains(provider) {
            selectedProviders.removeAll { $0 == provider }
        } else {
            selectedProviders.append(provider)
        }
    }
    
    func resetGame() {
        playerManager.loadPlayers()
        selectedType = .movie
    }
    
    func saveProviders() {
        moviesLeft = moviesWithCard.count
        let providersNumber = selectedProviders.map(\.rawValue)
        do {
            try providerRepository.saveProviders(providers: providersNumber)
        } catch {
            selectedProviders = []
        }
    }
    
    func loadProviders() {
        do {
            try selectedProviders = providerRepository.loadProviders()
        } catch {
            selectedProviders = []
        }
    }
}
