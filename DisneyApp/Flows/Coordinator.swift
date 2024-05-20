import Foundation
import UIKit
import SwiftUI
import Swinject

final class Coordinator {
    
    let navigationController: UINavigationController
    let servicesFactory: Resolver

    init(window: UIWindow?, servicesFactory: Resolver) {
        self.navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        self.servicesFactory = servicesFactory
    }

    func start() {
        let contentView = CharactersListView(
            viewStore: CharactersListViewStore(
                userRepository: servicesFactory.resolve(
                    UserRepository.self
                ),
                charactersRepository: servicesFactory.resolve(
                    CharactersRepository.self
                )
            )
        )

        let viewController = UIHostingController(rootView: contentView)
        navigationController.pushViewController(viewController, animated: false)
    }
}
