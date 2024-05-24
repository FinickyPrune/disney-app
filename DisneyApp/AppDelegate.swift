import UIKit
import FirebaseCore
import Swinject

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var rootCoordinator: Coordinator?
    private lazy var assembler: Assembler = Assembler([
        ServicesAssembly(),
        ScreenAssembly()
    ])

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        FirebaseApp.configure()

        window = UIWindow(frame: UIScreen.main.bounds)
    
        Task {
            await ConfigKeyProvider.shared.fetchAndActivateConfig()
            
            rootCoordinator = Coordinator(
                window: window,
                screenFactory: assembler.resolver
            )

            await MainActor.run {
                rootCoordinator?.start()
            }
        }

        return true
    }

}

