//
//  TVSerieDTOList.swift
//  MovieFlick
//
//  Created by Fran Malo on 1/9/24.
//

import Foundation

struct TVSerieList: Codable {
    let page: Int
    let results: [TVSerieDTO]
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
    }
}

struct TVSerieDTO: Codable {
    let adult: Bool
    let id: Int
    let backdropPath: String?
    let genreIDS: [Int]
    let originalName: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let firstAirDate: String
    let name: String
    let voteAverage: Double
    let voteCount: Int


    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case name
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension TVSerieDTO {
    func toTVSSerie() -> TVSerie {
        TVSerie(adult: adult,
                backdropPath: .imageURL(endPath: backdropPath ?? ""),
                genreIDS: genreIDS,
                id: id,
                originalTitle: originalName,
                overview: overview,
                popularity: popularity,
                posterPath: .imageURL(endPath: posterPath ?? ""),
                firstAirDate: firstAirDate,
                title: name,
                voteAverage: voteAverage,
                voteCount: voteCount)
    }
}
