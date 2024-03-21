import Foundation

struct UserInfo: Codable {
    let results: [UserDto]
}

struct UserDto: Codable {
    let name: String
    let image: String
}
