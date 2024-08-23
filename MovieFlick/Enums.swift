//
//  Enums.swift
//  MovieFlick
//
//  Created by Fran Malo on 21/8/24.
//

import Foundation


enum SortType: String {
    case originalTitleAsc = "original_title.asc"
    case popularityAsc = "popularity.asc"
    case revenueAsc = "revenue.asc"
    case primaryReleaseDateAsc = "primary_release_date.asc"
    case titleAsc = "title.asc"
    case voteAverageAsc = "vote_average.asc"
    case voteCountAsc = "vote_count.asc"
    
    case originalTitle = "original_title.desc"
    case popularity = "popularity.desc"
    case revenue = "revenue.desc"
    case primaryReleaseDate = "primary_release_date.desc"
    case title = "title.desc"
    case voteAverage = "vote_average.desc"
    case voteCount = "vote_count.desc"
}

enum Provider: Int {
    case netflix = 8
    case appleTV = 2
    case movistarPlus = 149
    case hboMax = 1899
    case youtubePremium = 188
    case amazonPrimeVideo = 119
    case flixOle = 393
    case disneyPlus = 337
    case filmin = 64
    case rakutenTV = 35
    case atresplayer = 62
    case rtve = 541
    case mubi = 11
    case skyShowtime = 1773
    case crunchyroll = 283
}

enum Genre: Int {
    case action = 28
    case adventure = 12
    case animation = 16
    case comedy = 35
    case crime = 80
    case documentary = 99
    case drama = 18
    case family = 10751
    case fantasy = 14
    case history = 36
    case horror = 27
    case music = 10402
    case mystery = 9648
    case romance = 10749
    case scienceFiction = 878
    case tvMovie = 10770
    case thriller = 53
    case war = 10752
    case western = 37
}


enum MonetizationType: String {
    case flatrate = "flatrate"
    case free = "free"
    case ads = "ads"
    case rent = "rent"
    case buy = "buy"
}
