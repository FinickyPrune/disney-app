import SwiftUI
import Swinject

final class ScreenAssembly: Assembly {

    func assemble(container: Container) {
        container.register(CharactersListViewStore.self) { resolver in
            CharactersListViewStore(
                userRepository: resolver.resolve(UserRepository.self),
                charactersRepository: resolver.resolve(CharactersRepository.self)
            )
        }
        
        container.register(CharactersListView.self) { resolver in
            CharactersListView(
                viewStore: resolver.resolve(CharactersListViewStore.self)
            )
        }
        
        container.register(
            UIViewController.self,
            name: container.charactersListViewName
        ) { resolver in
            UIHostingController(rootView: resolver.resolve(CharactersListView.self))
        }
    }
    
}
