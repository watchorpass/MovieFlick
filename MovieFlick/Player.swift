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
