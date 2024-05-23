import Foundation

protocol CharactersRepository {
    func getCharactersInfo() async -> Result<[CharacterDto], Error>
}

final class DisneyCharactersRepository: CharactersRepository {

    init(client: GenericAPI,
         charactersMaxCount: Int? = nil
    ) {
        self.client = client
        self.charactersMaxCount = charactersMaxCount
    }

    private let client: GenericAPI
    private let charactersMaxCount: Int?

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
            if let charactersMaxCount {
                return Result.success(Array(characters[0..<charactersMaxCount]))
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

    init(client: GenericAPI,
         charactersMaxCount: Int? = nil
    ) {
        self.client = client
        self.charactersMaxCount = charactersMaxCount
    }

    private let client: GenericAPI
    private let charactersMaxCount: Int?

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
            if let charactersMaxCount {
                return Result.success(Array(characters[0..<charactersMaxCount]))
            }
            return Result.success(characters)
        }
        catch {
            print(error.localizedDescription)
            return Result.failure(error)
        }

    }
}
