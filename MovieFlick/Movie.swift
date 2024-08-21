//
//  Movie.swift
//  MovieFlick
//
//  Created by Fran Malo on 19/8/24.
//

import Foundation

struct Movie: Identifiable, Hashable {
    let adult: Bool
    let backdropPath: URL?
    let genreIDS: [Int]
    let id: Int
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: URL?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
}
