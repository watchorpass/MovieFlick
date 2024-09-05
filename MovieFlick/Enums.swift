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

enum Provider: Int, CaseIterable {
    case all = 0
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
    
    static var avaibleProviders: [Self] {
        [.netflix, .amazonPrimeVideo, .hboMax, .appleTV, .movistarPlus, .disneyPlus, .filmin, .crunchyroll, .flixOle]
    }
}

enum Genre: Int, CaseIterable {
    case all = 0
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
    
    var description: String {
        switch self {
        case .all: return "All Genres"
        case .action: return "Action"
        case .adventure: return "Adventure"
        case .animation: return "Animation"
        case .comedy: return "Comedy"
        case .crime: return "Crime"
        case .documentary: return "Documentary"
        case .drama: return "Drama"
        case .family: return "Family"
        case .fantasy: return "Fantasy"
        case .history: return "History"
        case .horror: return "Horror"
        case .music: return "Music"
        case .mystery: return "Mystery"
        case .romance: return "Romance"
        case .scienceFiction: return "Science Fiction"
        case .tvMovie: return "TV Movie"
        case .thriller: return "Thriller"
        case .war: return "War"
        case .western: return "Western"
        }
    }
}

enum MonetizationType: String {
    case flatrate = "flatrate"
    case free = "free"
    case ads = "ads"
    case rent = "rent"
    case buy = "buy"
}
