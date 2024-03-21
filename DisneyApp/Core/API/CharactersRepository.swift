import Foundation

protocol CharactersRepository {
    func getCharactersInfo() async -> Result<[CharacterDto], Error>
}

final class CharactersRepositoryImpl: CharactersRepository {

    static private let charactersUrl = "https://api.disneyapi.dev/character"

    private let client = Client()

    private var charactersRequest: URLRequest = {
        let url = URL(string: charactersUrl)!
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringLocalCacheData

        return request
    }()

    func getCharactersInfo() async ->  Result<[CharacterDto], Error> {
        do {
            let listResponse = try await client.fetch(type: CharacterInfo.self, with: charactersRequest)
            return Result.success(listResponse.data)
        }
        catch {
            print(error.localizedDescription)
            return Result.failure(error)
        }

    }
}
