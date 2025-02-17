import SwiftUI
import PackageNetwork

protocol MovieListInteractorProtocol {
    func getMovies(page: Int?, sortBy: SortType?, providers: [Provider]?, genres: [Genre]?, monetizationTypes: [MonetizationType]?) async throws -> [Movie]
    func getSeries(page: Int?, sortBy: SortType?, providers: [Provider]?, genres: [Genre]?, monetizationTypes: [MonetizationType]?) async throws -> [Movie]
    func loadCardImages(for movies: [Movie]) async throws -> [Movie]
}

struct MovieListInteractor: MovieListInteractorProtocol, NetworkInteractor {
    
    let appConfig = AppConfig.shared
            
    func getMovies(page: Int?, sortBy: SortType?, providers: [Provider]?, genres: [Genre]?, monetizationTypes: [MonetizationType]?) async throws -> [Movie] {
        let url = URL.finalURLMovie(
            page: page,
            sortBy: sortBy,
            providers: providers,
            genres: genres,
            monetizationTypes: monetizationTypes)
        return try await getJSONFromURL(request: .get(url: url, token: appConfig.APIKey), type: MovieDTOList.self).results.map(\.toMovie)
    }
    
    func getSeries(page: Int?, sortBy: SortType?, providers: [Provider]?, genres: [Genre]?, monetizationTypes: [MonetizationType]?) async throws -> [Movie] {
        let url = URL.finalURLTVSeries(
            page: page,
            sortBy: sortBy,
            providers: providers,
            genres: genres,
            monetizationTypes: monetizationTypes)
        return try await getJSONFromURL(request: .get(url: url, token: appConfig.APIKey), type: TVSerieList.self).results.map(\.toMovie)
    }
    
    func loadCardImages(for movies: [Movie]) async throws -> [Movie] {
        var mutableMovies = movies.filter({ $0.posterPath != nil })
        
        try await withThrowingTaskGroup(of: (Int, UIImage?).self) { group in
            for (index, movie) in mutableMovies.enumerated() {
                guard let url = movie.posterPath else {
                    continue
                }
                
                group.addTask {
                    let image = try await getImage(url: url)
                    return (index, image)
                }
            }
            
            for try await (index, image) in group {
                mutableMovies[index].cardImage = image
            }
        }
        return mutableMovies
    }

    private func getImage(url: URL) async throws -> UIImage? {
        let (data, _) = try await URLSession.shared.data(from: url)
        if let image = UIImage(data: data){
            return image
        } else {
            throw URLError(.badServerResponse)
        }
    }
}
