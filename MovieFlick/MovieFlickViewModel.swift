

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

@Observable
final class MovieFlickViewModel {
    let interactor: MovieListInteractorProtocol
    var resultMovies: [Movie] = []
    var moviesWithCard: [Movie] = []
    var playersName: [String] = ["", ""]
    var movieSelected: Movie = Movie(adult: false, backdropPath: nil, genreIDS: [], id: 1, originalTitle: "original", overview: "", popularity: 1.1, posterPath: nil, releaseDate: "", title: "", video: false, voteAverage: 5.5, voteCount: 1)

    var swipeCount: Int = 0
    
    var viewState: ViewState = .startView
    var sortType: SortType = .popularity
    var selectedGenres: [Genre] = [.all]
    
    var showError = false
    var errorMsg = ""
    
    var showLoadingView = true    
    init(interactor: MovieListInteractorProtocol = MovieListInteractor()) {
        self.interactor = interactor
    }
    
    func wait5Segs() {
        Task {
            try? await Task.sleep(nanoseconds: 25_000_000_000)
            showLoadingView.toggle()
        }
    }
    
    func randomMovie() {
        if let movieWinner = resultMovies.randomElement() {
            movieSelected = movieWinner
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
            selectedGenres = [.all]
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
