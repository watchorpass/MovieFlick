import SwiftUI

@Observable
final class PlayerManager {
    var players: [Player] = [.emptyPlayer, .emptyPlayer]
    var selectedPlayer: Player = .emptyPlayer

    let repository: PlayersRepositoryProtocol
    
    init(repository: PlayersRepositoryProtocol = PlayersRepository()) {
        self.repository = repository
        loadPlayers()
    }
    
    func savePlayers() {
        let playerNames = players.map(\.name)
        do {
            try repository.savePlayers(players: playerNames)
        } catch {
            players = [.emptyPlayer, .emptyPlayer]
        }
    }

    func loadPlayers() {
        do {
            players = try repository.loadPlayers()
        } catch {
            players = [.emptyPlayer, .emptyPlayer]
        }
    }
    
    func addPlayer(name: String, index: Int ) {
        players[index] = Player(name: name)
    }
    
    func canBeAdded(player: Player) -> Bool {
        players.filter { $0.name == player.name }.count > 1
    }
    
    func updatePlayer(player: Player) {
        if let index = players.firstIndex(where: { $0.name == player.name }) {
            players[index] = player
        }
    }
    
    func nextPlayer(player: Player) -> Player? {
        guard let index = players.firstIndex(where: { $0.id == player.id }),
              index + 1 < players.count else { return nil }
        return players[index + 1]
    }
    
    func isLastPlayer(player: Player) -> Bool {
        players.last?.id == player.id
    }
    
    func removePlayer(player: Player) {
        players.removeAll { $0.id == player.id }
    }

    func isRepeatedOrEmptyPlayer() -> Bool {
        guard !players.map({ $0.name }).contains("") else {return true}
        return players.count != Set(players.map { $0.name.replacingOccurrences(of: " ", with: "") }).count
    }
    
    func resetPlayers() {
        selectedPlayer = .emptyPlayer
        players = []
        loadPlayers()
    }
}
