import UIKit
import FirebaseCore
import Swinject

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var rootCoordinator: Coordinator?
    private let assembler: Assembler = Assembler([
        ServicesAssembly(),
        ViewsAssembly(),
        ViewControllersAssembly()
    ])

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
    
        Task {
            await FeatureFlagProvider.shared.fetchAndActivateConfig()

            rootCoordinator = Coordinator(
                window: window,
                servicesFactory: assembler.resolver
            )

            await MainActor.run {
                rootCoordinator?.start()
            }
        }

        return true
    }

}

