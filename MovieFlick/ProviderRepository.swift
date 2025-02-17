import Foundation

protocol ProviderRepositoryProtocol {
    func saveProviders(providers: [Int]) throws
    func loadProviders() throws -> [Provider]
}

struct ProviderRepository: ProviderRepositoryProtocol {
    func saveProviders(providers: [Int]) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(providers)
        try data.write(to: URL.documentsDirectory.appending(path: "providersList.json"), options: .atomic)
    }
    
    func loadProviders() throws -> [Provider] {
        let data = try Data(contentsOf: URL.documentsDirectory.appending(path: "providersList.json"))
        let providers = try JSONDecoder().decode([Int].self, from: data)
        return providers.compactMap { Provider(rawValue: $0) }
    }
}
