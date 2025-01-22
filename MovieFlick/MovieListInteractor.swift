//
//  MovieListInteractor.swift
//  MovieFlick
//
//  Created by Fran Malo on 19/8/24.
//

import SwiftUI
import PackageNetwork

protocol MovieListInteractorProtocol {
    func getMovies(isAdult: Bool?, includesVideo: Bool?, page: Int?, sortBy: SortType?, releaseYear: Int?, dateGreaterThan: String?, dateLessThan: String?, voteGreaterThan: Double?, voteLessThan: Double?, region: String?, providers: [Provider]?, genres: [Genre]?, monetizationTypes: [MonetizationType]?) async throws -> [Movie]
    func getSeries(isAdult: Bool?, includesVideo: Bool?, page: Int?, sortBy: SortType?, releaseYear: Int?, dateGreaterThan: String?, dateLessThan: String?, voteGreaterThan: Double?, voteLessThan: Double?, region: String?, providers: [Provider]?, genres: [Genre]?, monetizationTypes: [MonetizationType]?) async throws -> [Movie]
    func loadCardImages(for movies: [Movie]) async throws -> [Movie]
    func savePlayers(players: [Player]) throws
    func loadPlayers() throws -> [Player]
}

struct MovieListInteractor: MovieListInteractorProtocol, NetworkInteractor {
    
    static let shared = MovieListInteractor()
    let appConfig = AppConfig.shared
        
    func getMovies(isAdult: Bool? = nil, includesVideo: Bool? = nil, page: Int? = nil, sortBy: SortType? = nil, releaseYear: Int? = nil, dateGreaterThan: String? = nil, dateLessThan: String? = nil, voteGreaterThan: Double? = nil, voteLessThan: Double? = nil, region: String? = nil, providers: [Provider]? = nil, genres: [Genre]? = nil, monetizationTypes: [MonetizationType]? = nil) async throws -> [Movie] {
        let url = URL.finalURLMovie(
            isAdult: isAdult,
            includesVideo: includesVideo,
            page: page,
            sortBy: sortBy,
            releaseYear: releaseYear,
            dateGreaterThan: dateGreaterThan,
            dateLessThan: dateLessThan,
            voteGreaterThan: voteGreaterThan,
            voteLessThan: voteLessThan,
            region: region,
            providers: providers,
            genres: genres,
            monetizationTypes: monetizationTypes)
        return try await getJSONFromURL(request: .get(url: url, token: appConfig.APIKey), type: MovieDTOList.self).results.map(\.toMovie)
    }
    
    func getSeries(isAdult: Bool? = nil, includesVideo: Bool? = nil, page: Int? = nil, sortBy: SortType? = nil, releaseYear: Int? = nil, dateGreaterThan: String? = nil, dateLessThan: String? = nil, voteGreaterThan: Double? = nil, voteLessThan: Double? = nil, region: String? = nil, providers: [Provider]? = nil, genres: [Genre]? = nil, monetizationTypes: [MonetizationType]? = nil) async throws -> [Movie] {
        let url = URL.finalURLTVSeries(
            isAdult: isAdult,
            page: page,
            sortBy: sortBy,
            airDateGreaterThan: dateGreaterThan,
            airDateLessThan: dateLessThan,
            voteGreaterThan: voteGreaterThan,
            voteLessThan: voteLessThan,
            region: region,
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
    
    func savePlayers(players: [Player]) throws {
        let data = try JSONEncoder().encode(players)
        try data.write(to: URL.documentsDirectory.appending(path: "playerList"), options: .atomic)
    }
    
    func loadPlayers() throws -> [Player] {
        let data = try Data(contentsOf: URL.documentsDirectory.appending(path: "playerList"))
        return try JSONDecoder().decode([Player].self, from: data)
    }
}
