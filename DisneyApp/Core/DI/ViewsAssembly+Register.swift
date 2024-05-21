import Foundation
import Swinject

final class ViewsAssembly: Assembly {

    func assemble(container: Container) {
        container.register(CharactersListViewStore.self) { resolver in
            return CharactersListViewStore(
                userRepository: resolver.resolve(UserRepository.self),
                charactersRepository: resolver.resolve(CharactersRepository.self)
            )
        }
        
        container.register(CharactersListView.self) { resolver in
            return CharactersListView(
                viewStore: resolver.resolve(CharactersListViewStore.self)
            )
        }
    }
    
}
