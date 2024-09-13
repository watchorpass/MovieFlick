//
//  SwipeViewPreviewData.swift
//  MovieFlick
//
//  Created by Alberto Alegre Bravo on 19/8/24.
//

import Foundation

struct MovieModel: Identifiable {
    var id: UUID { UUID() }
    let title: String
    let url: URL
}

let myMockArray: [MovieModel] = [
    MovieModel(title: "Spiderman", url: URL(string: "https://image.tmdb.org/t/p/w500/rweIrveL43TaxUN0akQEaAXL6x0.jpg")!),
    MovieModel(title: "Batman", url: URL(string: "https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg")!),
    MovieModel(title: "IronMan", url: URL(string: "https://image.tmdb.org/t/p/w500/78lPtwv72eTNqFW9COBYI0dWDJa.jpg")!),
    MovieModel(title: "Dr Strange", url: URL(string: "https://image.tmdb.org/t/p/w500/uGBVj3bEbCoZbDjjl9wTxcygko1.jpg")!),
    MovieModel(title: "Thor", url: URL(string: "https://image.tmdb.org/t/p/w500/prSfAi1xGrhLQNxVSUFh61xQ4Qy.jpg")!)
]


