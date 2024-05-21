import UIKit
import FirebaseCore
import Swinject

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var rootCoordinator: Coordinator?
    private var assembler: Assembler?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure(options: FirebaseOptions.defaultOptions()!)

        assembler = Assembler([
            ServicesAssembly(),
            ScreenAssembly()
        ])
        
        window = UIWindow(frame: UIScreen.main.bounds)
    
        Task {
            await FeatureFlagProvider.shared.fetchAndActivateConfig()

            guard let resolver = assembler?.resolver as? NameSpacedResolver else { return }
            
            rootCoordinator = Coordinator(
                window: window,
                servicesFactory: resolver
            )

            await MainActor.run {
                rootCoordinator?.start()
            }
        }

        return true
    }

}

