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
    case Netflix = 8
    case AppleTV = 2
    case MovistarPlus = 149
    case MAX = 1899
    case YoutubePremium = 188
    case PrimeVideo = 119
    case FlixOle = 393
    case DisneyPlus = 337
    case Filmin = 64
    case RakutenTV = 35
    case Atresplayer = 62
    case rtve = 541
    case mubi = 11
    case skyShowtime = 1773
    case Crunchyroll = 283
    
    static var avaibleProviders: [Self] {
        [.Netflix, .PrimeVideo, .MAX, .AppleTV, .MovistarPlus, .DisneyPlus, .Filmin, .Crunchyroll, .FlixOle]
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
    
    case actionAdventure = 10759
    case kids = 10762
    case news = 10763
    case reality = 10764
    case sciFiFantasy = 10765
    case soap = 10766
    case talk = 10767
    case warPolitics = 10768
    
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
            
        case .actionAdventure: return "Action & Adventure"
        case .kids: return "Kids"
        case .news: return "News"
        case .reality: return "Reality"
        case .sciFiFantasy: return "Sci-Fi & Fantasy"
        case .soap: return "Soap"
        case .talk: return "Talk"
        case .warPolitics: return "War & Politics"
        }
    }
    
    static var MovieGenres: [Self] {
        [.all,.action,.adventure,.animation,.comedy,.crime,.documentary,.drama,.family,.fantasy,.history,.horror,.music,.mystery,.romance,.scienceFiction,.tvMovie,.thriller,.war,.western]
    }
    static var TVGenres: [Self] {
        [.all, .actionAdventure, .animation, .comedy, .crime, .documentary, .drama, .family, .kids, .mystery, .news, .reality, .sciFiFantasy, .soap, .talk, .warPolitics, .western]
    }
    
    static func GenreListByType(type: SelectedType) -> [Self] {
        switch type {
        case .movie:
            Self.MovieGenres
        case .serie:
            Self.TVGenres
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
