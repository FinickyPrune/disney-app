import Foundation
import UIKit
import SwiftUI
import Swinject

final class Coordinator {
    
    let navigationController: UINavigationController
    let servicesFactory: NameSpacedResolver

    init(window: UIWindow?, servicesFactory: NameSpacedResolver) {
        self.navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        self.servicesFactory = servicesFactory
    }

    func start() {
        let viewController = servicesFactory.resolve(
            UIViewController.self,
            name: servicesFactory.charactersListViewName
        )
        navigationController.pushViewController(viewController, animated: false)
    }
}
