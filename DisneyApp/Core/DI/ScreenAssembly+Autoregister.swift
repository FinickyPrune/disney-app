import SwiftUI
import Swinject
import SwinjectAutoregistration

final class ScreenAssembly: Assembly {

    func assemble(container: Container) {
        
        var charactersMaxCount: Int?
        if ConfigKeyProvider.shared.isEnabled(.isHaveMaxCharactersCount) {
            charactersMaxCount = ConfigKeyProvider.shared.value(for: .charactersNumber)
        }
        
        container.autoregister(
            CharactersListViewStore.self,
            initializer: {
                CharactersListViewStore(
                    userRepository: container.resolve(UserRepository.self),
                    charactersRepository: container.resolve(CharactersRepository.self),
                    maxCharactersCount: charactersMaxCount
                )
            }
        )
        
        container.autoregister(
            CharactersListView.self,
            initializer: CharactersListView.init
        )
        
        container.autoregister(
            UIViewController.self,
            name: NameSpace.charactersListViewName,
            argument: CharactersListView.self,
            initializer: UIHostingController.init
        )
        
        container.autoregister(
            UIViewController.self,
            name: NameSpace.charactersListViewName,
            initializer: {
                container.resolve(
                    UIViewController.self,
                    name: NameSpace.charactersListViewName,
                    argument: container.resolve(CharactersListView.self)
                )
            }
        )
    }
}
