import Foundation
import UIKit
import SwiftUI
import Swinject

final class Coordinator {
    
    let navigationController: UINavigationController
    let screenFactory: Resolver

    init(window: UIWindow?, screenFactory: Resolver) {
        self.navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        self.screenFactory = screenFactory
    }

    func start() {
        let viewController = screenFactory.resolve(
            UIViewController.self,
            name: NameSpace.charactersListViewName
        )
        navigationController.pushViewController(viewController, animated: false)
    }
}
