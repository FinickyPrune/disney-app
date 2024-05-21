import Foundation
import UIKit
import SwiftUI
import Swinject

final class Coordinator {
    
    let navigationController: UINavigationController
    let screenFactory: NameSpacedResolver

    init(window: UIWindow?, servicesFactory: NameSpacedResolver) {
        self.navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        self.screenFactory = servicesFactory
    }

    func start() {
        let viewController = screenFactory.resolve(
            UIViewController.self,
            name: screenFactory.charactersListViewName
        )
        navigationController.pushViewController(viewController, animated: false)
    }
}
