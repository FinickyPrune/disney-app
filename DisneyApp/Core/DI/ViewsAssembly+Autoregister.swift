import Foundation
import Swinject
import SwinjectAutoregistration

final class ViewsAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(
            CharactersListViewStore.self,
            initializer: CharactersListViewStore.init
        )
        
        container.autoregister(
            CharactersListView.self,
            initializer: CharactersListView.init
        )
    }
}
