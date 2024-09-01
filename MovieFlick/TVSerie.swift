//
//  TVSerie.swift
//  MovieFlick
//
//  Created by Fran Malo on 1/9/24.
//

import SwiftUI

struct TVSerie: Identifiable, Hashable {
    let adult: Bool
    let backdropPath: URL?
    let genreIDS: [Int]
    let id: Int
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: URL?
    let firstAirDate: String
    let title: String
    let voteAverage: Double
    let voteCount: Int
    var cardImage: UIImage?
}
