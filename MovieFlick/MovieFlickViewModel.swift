

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
    case chooseWheel
}

@Observable
final class MovieFlickViewModel {
    let interactor: MovieListInteractorProtocol
    var resultMovies: [Movie] = []
    var moviesWithCard: [Movie] = []
    var playersName: [String] = ["", ""]
    
    var swipeCount: Int = 0
    
    var viewState: ViewState = .startView
    var sortType: SortType = .popularity
    var selectedGenre: Genre = .action
    
    init(interactor: MovieListInteractorProtocol = MovieListInteractor()) {
        self.interactor = interactor
        Task { 
            await fetchMovies()
        }
    }
    
    func restartCount() {
        swipeCount = moviesWithCard.count
    }
    
    func fetchMovies() async {
        do {
            let movies = try await interactor.getMovies(isAdult: true, includesVideo: false, page: 1, sortBy: .popularity, releaseYear: 2024, dateGreaterThan: nil, dateLessThan: nil, voteGreaterThan: nil, voteLessThan: nil, region: nil, providers: nil, genres: nil, monetizationTypes: nil)
            
            moviesWithCard = try await interactor.loadCardImages(for: movies).reversed()
            resultMovies = moviesWithCard
            swipeCount = moviesWithCard.count
        } catch {
            print(error)
        }
    }
    
    func removeCard(_ movie: Movie) {
        guard let index = moviesWithCard.firstIndex(where: {$0.id == movie.id }) else { return }
        moviesWithCard.remove(at: index)
        print(moviesWithCard.count)
    }
    
    func removeFromResultMovies(movie: Movie) {
        guard let index = resultMovies.firstIndex(where: {$0.id == movie.id}) else { return }
        
        resultMovies.remove(at: index)
    }
}
