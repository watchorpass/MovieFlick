//
//  Player.swift
//  MovieFlick
//
//  Created by Fran Ochoa on 1/10/24.
//

import Foundation

struct Player: Equatable, Hashable, Identifiable, Codable {

    var id = UUID()
    static let emptyPlayer = Player(name: "")
    var name: String {
        didSet {
            id = UUID()
        }
    }
    var moviesPassed = 0
}
