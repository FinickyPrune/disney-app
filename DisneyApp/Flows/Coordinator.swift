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
        let viewController = servicesFactory.resolve(
            UIViewController.self,
            name: UIViewController.charactersListControllerName
        )
        navigationController.pushViewController(viewController, animated: false)
    }
}
