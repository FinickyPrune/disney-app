import Foundation

protocol UserRepository {
    func getUserInfo() async -> Result<UserDto, Error>
}

final class UserRepositoryImpl: UserRepository {

    init(client: GenericAPI) {
        self.client = client
    }

    static private let usersUrl = "https://rickandmortyapi.com/api/character"

    private let client: GenericAPI

    private var usersRequest: URLRequest = {
        let url = URL(string: usersUrl)!

        return URLRequest(url: url)
    }()

    func getUserInfo() async ->  Result<UserDto, Error> {
        do {
            let usersResponse = try await client.fetch(type: UserInfo.self, with: usersRequest)
            guard let user = usersResponse.results.randomElement()  else {
                return Result.failure(APIError.invalidData)
            }

            return Result.success(user)
        }
        catch {
            print(error.localizedDescription)
            return Result.failure(error)
        }

    }
}
