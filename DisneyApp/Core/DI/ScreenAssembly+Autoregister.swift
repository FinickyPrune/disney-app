import SwiftUI
import Swinject
import SwinjectAutoregistration

final class ScreenAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(
            CharactersListViewStore.self,
            initializer: CharactersListViewStore.init
        )
        
        container.autoregister(
            CharactersListView.self,
            initializer: CharactersListView.init
        )
        
        container.autoregister(
            UIViewController.self,
            name: UIViewController.charactersListControllerName,
            argument: CharactersListView.self,
            initializer: { view in
                UIHostingController(rootView: view)
            }
        )
        
        container.autoregister(
            UIViewController.self,
            name: UIViewController.charactersListControllerName,
            initializer: {
                container.resolve(
                    UIViewController.self,
                    name: UIViewController.charactersListControllerName,
                    argument: container.resolve(CharactersListView.self)!
                )
            }
        )
    }
}
