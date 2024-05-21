import Foundation
import SwiftUI
import Swinject

final class ViewControllersAssembly: Assembly {

    func assemble(container: Container) {
        container.register(
            UIViewController.self,
            name: UIViewController.charactersListControllerName
        ) { resolver in
            return UIHostingController(rootView: resolver.resolve(CharactersListView.self))
        }
    }
    
}
