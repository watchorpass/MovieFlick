//
//  PreviewData.swift
//  MovieFlick
//
//  Created by Fran Malo on 20/8/24.
//

import SwiftUI

struct MovieListInteractorPreview: MovieListInteractorProtocol {
    func getMovies(isAdult: Bool?, includesVideo: Bool?, page: Int?, sortBy: SortType?, releaseYear: Int?, dateGreaterThan: String?, dateLessThan: String?, voteGreaterThan: Double?, voteLessThan: Double?, region: String?, providers: [Provider]?, genres: [Genre]?, monetizationTypes: [MonetizationType]?) async throws -> [Movie] {
        let url = Bundle.main.url(forResource: "PreviewDataMovieList", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try decoder.decode(MovieDTOList.self, from: data).results.map(\.toMovie)
    }
    
    func loadCardImages(for movies: [Movie]) async throws -> [Movie] {
        []
    }
}





