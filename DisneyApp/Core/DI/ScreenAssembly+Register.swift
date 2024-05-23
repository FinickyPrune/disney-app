import SwiftUI
import Swinject

final class ScreenAssembly: Assembly {

    func assemble(container: Container) {
        
        var charactersMaxCount: Int?
        if ConfigKeyProvider.shared.isEnabled(.isHaveMaxCharactersCount) {
            charactersMaxCount = ConfigKeyProvider.shared.value(for: .charactersNumber)
        }
        
        container.register(CharactersListViewStore.self) { resolver in
            CharactersListViewStore(
                userRepository: resolver.resolve(UserRepository.self),
                charactersRepository: resolver.resolve(CharactersRepository.self),
                maxCharactersCount: charactersMaxCount
            )
        }
        
        container.register(CharactersListView.self) { resolver in
            CharactersListView(
                viewStore: resolver.resolve(CharactersListViewStore.self)
            )
        }
        
        container.register(
            UIViewController.self,
            name: NameSpace.charactersListViewName
        ) { resolver in
            UIHostingController(rootView: resolver.resolve(CharactersListView.self))
        }
    }
    
}
