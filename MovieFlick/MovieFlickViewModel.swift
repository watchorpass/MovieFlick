

import SwiftUI

enum ViewState {
    case startView
    case playersView
    case chooseTypeView
    case filterView
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
    var movieSelected: Movie = .movieExample

    var swipeCount: Int = 0
    
    var viewState: ViewState = .startView
    var sortType: SortType = .popularity
    var selectedGenres: [Genre] = [.all]
    var selectedType: SelectedType = .movie
    
    var showError = false
    var errorMsg = ""
    
    var showLoadingView = true    
    
    init(interactor: MovieListInteractorProtocol = MovieListInteractor()) {
        self.interactor = interactor
    }
    
    func randomMovie() {
        if let movieWinner = resultMovies.randomElement() {
            movieSelected = movieWinner
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
            let movies = try await interactor.getMovies(isAdult: true, includesVideo: false, page: 1, sortBy: .popularity, releaseYear: 2024, dateGreaterThan: nil, dateLessThan: nil, voteGreaterThan: nil, voteLessThan: nil, region: nil, providers: nil, genres: selectedGenres, monetizationTypes: nil)
            
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
            let movies = try await interactor.getSeries(isAdult: true, includesVideo: false, page: 1, sortBy: .popularity, releaseYear: 2024, dateGreaterThan: nil, dateLessThan: nil, voteGreaterThan: nil, voteLessThan: nil, region: nil, providers: nil, genres: selectedGenres, monetizationTypes: nil)
            
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
}
