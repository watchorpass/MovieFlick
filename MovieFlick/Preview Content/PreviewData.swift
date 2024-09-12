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

extension Movie {
    static let previewMovie = Movie(
        adult: false,
        backdropPath: URL(string: "https://image.tmdb.org/t/p/w500/s0OrExdg7i3RLR7oqzHRk4q2kL4.jpg"),
        genreIDS: [18, 35],
        id: 194662,
        originalTitle: "Birdman or (The Unexpected Virtue of Ignorance)",
        overview: "Después de hacerse famoso interpretando a un célebre superhéroe, un actor trata de darle un nuevo rumbo a su vida, recuperando a su familia y preparándose para el estreno de una obra teatral en Broadway.",
        popularity: 72.211,
        posterPath: URL(string: "https://image.tmdb.org/t/p/w500/lJxWFRrQIOphpD3oPjD0J0d9JYY.jpg"),
        releaseDate: "2014-10-17",
        title: "Birdman o (la inesperada virtud de la ignorancia)",
        video: false,
        voteAverage: 7.466,
        voteCount: 12619,
        cardImage: UIImage(resource: .breakingBadPoster)
    )
}





