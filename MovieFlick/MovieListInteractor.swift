//
//  MovieListInteractor.swift
//  MovieFlick
//
//  Created by Fran Malo on 19/8/24.
//

import Foundation
import PackageNetwork


protocol MovieListInteractorProtocol {
    func getMovies(isAdult: Bool?, includesVideo: Bool?, page: Int?, sortBy: SortType?, releaseYear: Int?, dateGreaterThan: String?, dateLessThan: String?, voteGreaterThan: Double?, voteLessThan: Double?, region: String?, providers: [Provider]?, genres: [Genre]?, monetizationTypes: [MonetizationType]?) async throws -> [Movie]
}


struct MovieListInteractor: MovieListInteractorProtocol, NetworkInteractor {
    
    static let shared = MovieListInteractor()
        
    func getMovies(isAdult: Bool? = nil, includesVideo: Bool? = nil, page: Int? = nil, sortBy: SortType? = nil, releaseYear: Int? = nil, dateGreaterThan: String? = nil, dateLessThan: String? = nil, voteGreaterThan: Double? = nil, voteLessThan: Double? = nil, region: String? = nil, providers: [Provider]? = nil, genres: [Genre]? = nil, monetizationTypes: [MonetizationType]? = nil) async throws -> [Movie] {
        
        let url = URL.finalURL(isAdult: isAdult,
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
        
        let request = try await URLRequest.get(url: url, token: AppConfig().AccessTokenAuth)
        //print(request)
        let result = try await getJSONFromURL(request: request, type: MovieList.self)
        //print(result)
        return result.results.map { $0.toMovie() }
    }
}
