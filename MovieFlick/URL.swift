//
//  URL.swift
//  MovieFlick
//
//  Created by Fran Malo on 16/8/24.
//

import Foundation


let mainURL = URL(string: "https://api.themoviedb.org/3/discover")!
let imageBaseUrl = URL(string: "https://image.tmdb.org/t/p/w600_and_h900_bestv2")!

extension URL {
    static let movieURL = mainURL.appending(path: "movie")
    static func finalURL(
        isAdult: Bool? = nil,
        includesVideo: Bool? = nil,
        page: Int? = nil,
        sortBy: SortType? = nil,
        releaseYear: Int? = nil,
        dateGreaterThan: String? = nil,
        dateLessThan: String? = nil,
        voteGreaterThan: Double? = nil,
        voteLessThan: Double? = nil,
        region: String? = nil,
        providers: [Provider]? = nil,
        genres: [Genre]? = nil,
        monetizationTypes: [MonetizationType]? = nil) -> URL {
            
        var queryItems: [URLQueryItem] = []
            
        if let isAdult = isAdult {
            queryItems.append(.includeAdult(isAdult: isAdult))
        }
        if let includesVideo = includesVideo {
            queryItems.append(.includeVideo(withVideo: includesVideo))
        }
        if let page = page {
            queryItems.append(.page(page: page))
        }
        if let sortBy = sortBy {
            queryItems.append(.sortBy(sortBy: sortBy))
        }
        if let releaseYear = releaseYear {
            queryItems.append(.releaseYear(year: releaseYear))
        }
        if let dateGreaterThan = dateGreaterThan {
            queryItems.append(.dateGreaterThan(date: dateGreaterThan))
        }
        if let dateLessThan = dateLessThan {
            queryItems.append(.dateLessThan(date: dateLessThan))
        }
        if let voteGreaterThan = voteGreaterThan {
            queryItems.append(.voteGreaterThan(rate: voteGreaterThan))
        }
        if let voteLessThan = voteLessThan {
            queryItems.append(.voteLessThan(rate: voteLessThan))
        }
        if let region = region {
            queryItems.append(.region(region: region))
        }
        if let providers = providers {
            if !providers.contains(.all) {
                queryItems.append(.providers(providers: providers))
            }
            queryItems.append(.providers(providers: providers))
        }
        if let genres = genres {
            if !genres.contains(.all) {
                queryItems.append(.genres(genre: genres))
            }
        }
        if let monetizationTypes = monetizationTypes {
            queryItems.append(.monetizationTypes(types: monetizationTypes))
        }
        return movieURL.appending(queryItems: queryItems)
    }
    static func imageURL(endPath: String?) -> URL? {
        guard let path = endPath else { return nil }
        return imageBaseUrl.appending(path: path)
    }
}


extension URLQueryItem {
    static func includeAdult(isAdult: Bool) -> URLQueryItem {
        URLQueryItem(name: "include_adult", value: String(isAdult) )
    }
    static func includeVideo(withVideo: Bool) -> URLQueryItem {
        URLQueryItem(name: "include_video", value: String(withVideo) )
    }
    static func page(page: Int) -> URLQueryItem {
        URLQueryItem(name: "page", value: "\(page)")
    }
    static func releaseYear(year: Int) -> URLQueryItem {
        URLQueryItem(name: "primary_release_year", value: "\(year)")
    }
    static func dateGreaterThan(date: String) -> URLQueryItem {
        URLQueryItem(name: "release_date.gte", value: date)
    }
    static func dateLessThan(date: String) -> URLQueryItem {
        URLQueryItem(name: "release_date.lte", value: date)
    }
    static func sortBy(sortBy: SortType) -> URLQueryItem {
        URLQueryItem(name: "sort_by", value: sortBy.rawValue)
    }
    static func voteGreaterThan(rate: Double) -> URLQueryItem {
        URLQueryItem(name: "vote_average.gte", value: "\(rate)")
    }
    static func voteLessThan(rate: Double) -> URLQueryItem {
        URLQueryItem(name: "vote_average.lte", value: "\(rate)")
    }
    static func region(region: String) -> URLQueryItem {
        URLQueryItem(name: "watch_region", value: region)
    }
    static func providers(providers: [Provider]) -> URLQueryItem {
        let providersID = providers.map { String($0.rawValue) }.joined(separator: ",")
        return URLQueryItem(name: "with_watch_providers", value: providersID)
    }
    static func genres(genre: [Genre]) -> URLQueryItem {
        let genreIDs = genre.map { String($0.rawValue) }.joined(separator: ",")
        return URLQueryItem(name: "with_genres", value: genreIDs)
    }
    static func monetizationTypes(types: [MonetizationType]) -> URLQueryItem {
        let typesString = types.map { $0.rawValue }.joined(separator: ",")
        return URLQueryItem(name: "with_watch_monetization_types", value: typesString)
    }
}
