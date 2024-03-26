import Foundation

struct CharactersData: Codable {
    let data: [CharacterDto]?
    let characters: [CharacterDto]?
}

struct CharacterDto: Codable {
    let name: String
    let imageUrl: String?
    let image: String?
    let images: [String]?
}
