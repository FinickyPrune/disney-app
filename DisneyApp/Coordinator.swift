import Foundation
import UIKit
import SwiftUI

class Coordinator {
    
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let contentView = MainAssembly.container.resolve(CharactersListView.self)

        let viewController = UIHostingController(rootView: contentView)
        navigationController.pushViewController(viewController, animated: false)
    }
}
