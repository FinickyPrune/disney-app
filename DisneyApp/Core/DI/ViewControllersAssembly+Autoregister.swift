import Foundation
import SwiftUI
import Swinject
import SwinjectAutoregistration

final class ViewControllersAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(
            UIViewController.self,
            name: UIViewController.charactersListControllerName,
            argument: CharactersListView.self,
            initializer: { view in
                return UIHostingController(rootView: view)
            }
        )
        
        container.autoregister(
            UIViewController.self,
            name: UIViewController.charactersListControllerName,
            initializer: {
                return container.resolve(
                    UIViewController.self,
                    name: UIViewController.charactersListControllerName,
                    argument: container.resolve(CharactersListView.self)!
                )
            }
        )
    }
    
}
