//
//  AppConfig.swift
//  MovieFlick
//
//  Created by Fran Malo on 19/8/24.
//

import Foundation

final class AppConfig {
    static let shared = AppConfig()
    
    var APIKey: String?
    
    init () {
        try? getApiKey()
    }
    
    private func getApiKey() throws {
//        guard let url = Bundle.main.url(forResource: "configAPI", withExtension: "plist") else { return }
//        let data = try Data(contentsOf: url)
//        let _ = try PropertyListDecoder().decode([String: String].self, from: data)
        //APIKey = plist["API_Key_Auth"]
        APIKey = " eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhOGE4M2ZiM2IxZmJlODFlNzY2ZjhiM2IwZDQ5MTgxYSIsIm5iZiI6MTcyNDc0ODAzNS4wMDU0NzYsInN1YiI6IjY2Y2Q4ZmY2ZDQ2ZmQxMGFmMmEyOWY1YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gaGqBpnVLSDF5TFDbA5YIKiDq6k_HoyT1oNFMGsAYMU"
    }
}
