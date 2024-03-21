import Foundation
import UIKit
import SwiftUI

class Coordinator {
    
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let contentView = CharactersListView()

        let viewController = UIHostingController(rootView: contentView)
        navigationController.pushViewController(viewController, animated: false)
    }
}
