

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
    var moviesLeft = 20
    
    var selectedMovie: Movie?
    
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
        loadPlayer()
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
        let randomPage = Int.random(in: 1..<10)
        do {
            let movies = try await interactor.getMovies(isAdult: true, includesVideo: nil, page: randomPage, sortBy: .popularity, releaseYear: nil, dateGreaterThan: nil, dateLessThan: nil, voteGreaterThan: nil, voteLessThan: nil, region: "ES", providers: selectedProviders, genres: selectedGenres, monetizationTypes: [.flatrate])
            
            moviesWithCard = try await interactor.loadCardImages(for: movies).reversed()
            resultMovies = moviesWithCard
            swipeCount = moviesWithCard.count
        } catch {
            showError.toggle()
            errorMsg = "Check your internet connection and try again"
        }
    }
    
    func fetchSeries() async {
        let randomPage = Int.random(in: 1..<10)
        do {
            let movies = try await interactor.getSeries(isAdult: true, includesVideo: nil, page: randomPage, sortBy: .popularity, releaseYear: nil, dateGreaterThan: nil, dateLessThan: nil, voteGreaterThan: nil, voteLessThan: nil, region: "ES", providers: selectedProviders, genres: selectedGenres, monetizationTypes: [.flatrate])
            
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
        players.map { $0.name }.contains("")
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
        if let index = players.firstIndex(where: { $0.id == player.id }) {
            if index + 1 < players.count {
                return players[index + 1]
            }
        }
        return nil
    }
    func isLastPlayer(player: Player) -> Bool {
        players.last?.id ?? .none  == player.id
    }
    
    func isFirstOfHisName(player: Player) -> Bool {
        if player.name.isEmpty {
            return true
        }
        if let index = players.firstIndex(where: { $0.name == player.name }) {
            return players[index].id == player.id
        }
        return false
    }
    
    func noSecondNames() -> Bool {
        return !players.allSatisfy({isFirstOfHisName(player: $0)})
    }
    
    func resetGame() {
        selectedGenres = [.all]
        selectedType = .movie
        loadPlayer()
    }
    
    func savePlayer() {
        let playerName = players.map(\.name)
        do {
            try interactor.savePlayers(players: playerName)
        } catch {}
    }
    
    func loadPlayer() {
        do {
            try players = interactor.loadPlayers()
        } catch {}
    }
}
