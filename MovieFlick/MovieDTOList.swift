//
//  MovieList.swift
//  MovieFlick
//
//  Created by Fran Malo on 19/8/24.
//

import Foundation

struct MovieDTOList: Codable {
    let page: Int
    let results: [MovieDTO]
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
    }
}

struct MovieDTO: Codable {
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
extension MovieDTO {
    var toMovie: Movie {
        Movie(adult: adult,
              backdropPath: .imageURL(endPath: backdropPath ?? ""),
              genreIDS: genreIDS,
              id: id,
              originalTitle: originalTitle,
              overview: overview,
              popularity: popularity,
              posterPath: .imageURL(endPath: posterPath ?? ""),
              releaseDate: releaseDate,
              title: title,
              video: video,
              voteAverage: voteAverage,
              voteCount: voteCount,
              cardImage: nil)
    }
}
