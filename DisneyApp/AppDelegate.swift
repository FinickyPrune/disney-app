import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootCoordinator: Coordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        self.configFirebase()

        window = UIWindow(frame: UIScreen.main.bounds)
    
        Task {
            await MainAssembly.shared.remoteConfigService.fetchAndActivateConfig()

            rootCoordinator = Coordinator(window: window)

            await MainActor.run {
                rootCoordinator?.start()
            }
        }

        return true
    }

    private func configFirebase() {
        let filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")!
        let options = FirebaseOptions(contentsOfFile: filePath)
        FirebaseApp.configure(options: options!)
    }

}

