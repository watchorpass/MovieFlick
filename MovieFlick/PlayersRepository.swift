import Foundation

protocol PlayersRepositoryProtocol {
    func savePlayers(players: [String]) throws
    func loadPlayers() throws -> [Player]
}

struct PlayersRepository: PlayersRepositoryProtocol {
    func savePlayers(players: [String]) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(players)
        try data.write(to: URL.documentsDirectory.appending(path: "playerList.json"), options: .atomic)
    }
    
    func loadPlayers() throws -> [Player] {
        let data = try Data(contentsOf: URL.documentsDirectory.appending(path: "playerList.json"))
        let playersName = try JSONDecoder().decode([String].self, from: data)
        return playersName.map { Player(name: $0) }
    }
}
