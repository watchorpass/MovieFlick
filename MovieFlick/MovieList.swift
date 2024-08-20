//
//  MovieList.swift
//  MovieFlick
//
//  Created by Fran Malo on 19/8/24.
//

import Foundation

struct MovieList: Codable {
    let page: Int
    let results: [MovieResult]
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
    }
}

// MARK: - Result
struct MovieResult: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
extension MovieResult {
    func toMovie() -> Movie {
        Movie(adult: adult,
              backdropPath: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/abcd1234.jpg\(backdropPath ?? "")",
              genreIDS: genreIDS,
              id: id,
              originalTitle: originalTitle,
              overview: overview,
              popularity: popularity,
              posterPath: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/abcd1234.jpg\(posterPath ?? "")",
              releaseDate: releaseDate,
              title: title,
              video: video,
              voteAverage: voteAverage,
              voteCount: voteCount)
    }
}
