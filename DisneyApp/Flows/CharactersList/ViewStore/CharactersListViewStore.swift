import Foundation

final class CharactersListViewStore: ObservableObject {

    init(userRepository: UserRepository, charactersRepository: CharactersRepository) {
        self.userRepository = userRepository
        self.charactersRepository = charactersRepository
    }

    @Published var state: State = .initial

    enum State: Hashable {
        case initial
        case loaded(data: Data)
        case error

        struct Data: Hashable {
            struct User: Hashable {
                let name: String
                let image: String
            }

            struct Character: Hashable {
                let name: String
                let image: String
            }

            let user: User
            let characters: [Character]
        }
    }

    func loadData() {
        Task { @MainActor in
            let userResult = await userRepository.getUserInfo()
            let charactersResult = await charactersRepository.getCharactersInfo()

            guard case let .success(user) = userResult,
                  case let .success(characters) = charactersResult else {
                self.updateState(.error)
                return
            }
            self.updateState(.loaded(data: State.Data(
                    user: State.Data.User(
                    name: user.name,
                    image: user.image
                ),
                characters: characters.map {
                    State.Data.Character(
                        name: $0.name,
                        image: $0.imageUrl ?? ""
                    )
                })
            ))

        }
    }

    private func updateState(_ newValue: State) {
        guard self.state != newValue else { return }
        self.state = newValue
    }

    private let userRepository: UserRepository
    private let charactersRepository: CharactersRepository
}
