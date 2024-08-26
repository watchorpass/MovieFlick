

import SwiftUI

@Observable
final class MovieFlickViewModel {
    let interactor: MovieListInteractorProtocol
    var movies: [Movie] = []
    var moviesWithCard: [Movie] = []
    
    
    init(interactor: MovieListInteractorProtocol = MovieListInteractor()) {
        self.interactor = interactor
        Task { 
            await fetchMovies()
        }
    }
    
    func fetchMovies() async {
        do {
            let movies = try await interactor.getMovies(isAdult: true, includesVideo: false, page: 1, sortBy: .popularity, releaseYear: 2022, dateGreaterThan: nil, dateLessThan: nil, voteGreaterThan: nil, voteLessThan: nil, region: nil, providers: nil, genres: nil, monetizationTypes: nil)
            
            moviesWithCard = try await interactor.loadCardImages(for: movies)
        } catch {
            print(error)
        }
    }
    
    func removeCard(_ movie: Movie) {
        guard let index = moviesWithCard.firstIndex(where: {$0.id == movie.id }) else { return }
        moviesWithCard.remove(at: index)
        print(moviesWithCard.count)
    }
}
