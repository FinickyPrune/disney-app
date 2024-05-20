import Foundation

protocol CharactersRepository {
    func getCharactersInfo() async -> Result<[CharacterDto], Error>
}

final class DisneyCharactersRepository: CharactersRepository {

    init(client: GenericAPI) {
        self.client = client
    }

    private let client: GenericAPI

    private var charactersRequest: URLRequest = {
        let url = URL(string: APIPath.disneyCharactersUrl)!
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringLocalCacheData

        return request
    }()

    func getCharactersInfo() async ->  Result<[CharacterDto], Error> {
        do {
            let listResponse = try await client.fetch(
                type: CharactersData.self,
                with: charactersRequest
            )
            guard let characters = listResponse.data else {
                return Result.failure(APIError.invalidData)
            }
            return Result.success(characters)
        }
        catch {
            print(error.localizedDescription)
            return Result.failure(error)
        }

    }
}

final class NarutoCharactersRepository: CharactersRepository {

    init(client: GenericAPI) {
        self.client = client
    }

    private let client: GenericAPI

    private var charactersRequest: URLRequest = {
        let url = URL(string: APIPath.narutoCharactersUrl)!
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringLocalCacheData

        return request
    }()

    func getCharactersInfo() async ->  Result<[CharacterDto], Error> {
        do {
            let listResponse = try await client.fetch(
                type: CharactersData.self,
                with: charactersRequest
            )
            guard let characters = listResponse.characters else {
                return Result.failure(APIError.invalidData)
            }
            return Result.success(characters)
        }
        catch {
            print(error.localizedDescription)
            return Result.failure(error)
        }

    }
}
