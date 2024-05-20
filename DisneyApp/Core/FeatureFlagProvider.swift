import Foundation
import FirebaseCore
import FirebaseRemoteConfig

protocol FeatureFlagProviding {
    func  isEnabled(_ flag: FeatureFlag) -> Bool
}

final class FeatureFlagProvider: FeatureFlagProviding {
    
    static let shared: FeatureFlagProvider = FeatureFlagProvider()
    
    private init(minimumFetchInterval: Double = 0.0) {
        let filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")!
        let options = FirebaseOptions(contentsOfFile: filePath)
        FirebaseApp.configure(options: options!)
        
        self.remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = minimumFetchInterval
        self.remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
    }
    
    func  isEnabled(_ flag: FeatureFlag) -> Bool {
        switch flag {
        case .isUserMocked:
            true
        case .isDisneyCharacters:
            true
        }
    }
    
    func fetchAndActivateConfig() async {
        do {
            try await self.remoteConfig.fetchAndActivate()
        } catch {
            print(error.localizedDescription)
        }
    }

    private let remoteConfig: RemoteConfig
}
