import Foundation
import UIKit
import SwiftUI

class Coordinator {
    
    let navigationController: UINavigationController

    init(window: UIWindow?) {
        self.navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func start() {
        let contentView = CharactersListView(
            viewStore: CharactersListViewStore(
                userRepository: MainAssembly.shared.container.resolve(
                    UserRepository.self
                ),
                charactersRepository: MainAssembly.shared.container.resolve(
                    CharactersRepository.self
                )
            )
        )

        let viewController = UIHostingController(rootView: contentView)
        navigationController.pushViewController(viewController, animated: false)
    }
}
