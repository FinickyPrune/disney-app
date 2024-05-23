import Foundation

final class CharactersListViewStore: ObservableObject {

    init(
        userRepository: UserRepository,
        charactersRepository: CharactersRepository,
        maxCharactersCount: Int? = nil
    ) {
        self.userRepository = userRepository
        self.charactersRepository = charactersRepository
        self.maxCharactersCount = maxCharactersCount
    }

    @Published var state: State = .initial

    enum State: Hashable {
        case initial
        case loaded(data: Data)
        case error

        struct Data: Hashable {
            
            init(user: UserDto, characters: [CharacterDto]) {
                self.user = User(user)
                self.characters = characters.map { Character($0) }
            }
            
            struct User: Hashable {
                
                init(_ user: UserDto) {
                    self.name = user.name
                    self.image = user.image
                }
                
                let name: String
                let image: String
            }

            struct Character: Hashable {
                
                init(_ character: CharacterDto) {
                    self.name = character.name
                    self.image = character.imageUrl ?? character.images?.first ?? ""
                    
                }
                
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
            
            var displayCharacters = characters
            if let maxCharactersCount {
                displayCharacters = Array(characters[0..<maxCharactersCount])
            }
            
            self.updateState(.loaded(data: State.Data(
                user: user,
                characters: displayCharacters
            )))
        }
    }

    private func updateState(_ newValue: State) {
        guard self.state != newValue else { return }
        self.state = newValue
    }

    private let userRepository: UserRepository
    private let charactersRepository: CharactersRepository
    private let maxCharactersCount: Int?
}
