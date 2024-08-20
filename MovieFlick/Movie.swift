//
//  Movie.swift
//  MovieFlick
//
//  Created by Fran Malo on 19/8/24.
//

import Foundation

struct Movie: Identifiable, Hashable {
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
}
