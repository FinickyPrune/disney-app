import Foundation

struct CharacterInfo: Codable {
    let data: [CharacterDto]
}

struct CharacterDto: Codable {
    let name: String
    let imageUrl: String?
}
