import SwiftUI

enum ViewState {
    case startView
    case aboutLegalView
    case playersView
    case chooseTypeView
    case filterView
    case providerView
    case genreView
    case swipeView
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
    var players: [Player] = [.emptyPlayer, .emptyPlayer]
    var selectedPlayer: Player = .emptyPlayer
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
    
    let swipeTip = SwipeTip()
    let genreTip = GenreTip()
    let chooseOneTip = ChooseOneTip()
    
    var showLoadingView = false
    private var timer: Timer?
    
    init(interactor: MovieListInteractorProtocol = MovieListInteractor()) {
        self.interactor = interactor
        loadPlayer()
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
            let movies = try await interactor.getMovies(isAdult: true, includesVideo: nil, page: randomPage, sortBy: .popularity, releaseYear: nil, dateGreaterThan: nil, dateLessThan: nil, voteGreaterThan: nil, voteLessThan: nil, region: "ES", providers: selectedProviders, genres: selectedGenres, monetizationTypes: [.flatrate])
            moviesWithCard = try await interactor.loadCardImages(for: movies).reversed()
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
            let movies = try await interactor.getSeries(isAdult: true, includesVideo: nil, page: randomPage, sortBy: .popularity, releaseYear: nil, dateGreaterThan: nil, dateLessThan: nil, voteGreaterThan: nil, voteLessThan: nil, region: "ES", providers: selectedProviders, genres: selectedGenres, monetizationTypes: [.flatrate])
            
            moviesWithCard = try await interactor.loadCardImages(for: movies).reversed()
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
    
    func addPlayer(name: String, index: Int ) {
        players[index] = Player(name: name)
    }
    
    func canBeAdded(player: Player) -> Bool {
        players.filter { $0.name == player.name }.count > 1
    }
    
    func updatePlayer(player: Player) {
        if let index = players.firstIndex(where: { $0.name == player.name }) {
            players[index] = player
        }
    }
    
    func nextPlayer(player: Player) -> Player? {
        guard let index = players.firstIndex(where: { $0.id == player.id }),
              index + 1 < players.count else { return nil }
        return players[index + 1]
    }
    
    func isLastPlayer(player: Player) -> Bool {
        players.last?.id == player.id
    }
    
    func removePlayer(player: Player) {
        players.removeAll { $0.id == player.id }
    }

    func isRepeatedOrEmptyPlayer() -> Bool {
        guard !players.map({ $0.name }).contains("") else {return true}
        return players.count != Set(players.map { $0.name.replacingOccurrences(of: " ", with: "") }).count
    }
    
    func resetGame() {
        selectedType = .movie
        loadPlayer()
    }
    
    func savePlayer() {
        let playerName = players.map(\.name)
        do {
            try interactor.savePlayers(players: playerName)
        } catch {
            players = [.emptyPlayer, .emptyPlayer]
        }
    }
    
    func loadPlayer() {
        do {
            try players = interactor.loadPlayers()
        } catch {
            players = [.emptyPlayer, .emptyPlayer]
        }
    }
    
    func saveProviders() {
        moviesLeft = moviesWithCard.count
        let providersNumber = selectedProviders.map(\.rawValue)
        do {
            try interactor.saveProviders(providers: providersNumber)
        } catch {
            selectedProviders = []
        }
    }
    
    func loadProviders() {
        do {
            try selectedProviders = interactor.loadProviders()
        } catch {
            selectedProviders = []
        }
    }
}
