import Foundation
import FirebaseCore
import FirebaseRemoteConfig

protocol FeatureFlagProviding {
    func  isEnabled(_ flag: FeatureFlag) -> Bool
}

protocol AdjustValueProviding {
    func  value(for: AdjustValue) -> Int
}

final class ConfigKeyProvider: FeatureFlagProviding, AdjustValueProviding {
    
    static let shared: ConfigKeyProvider = ConfigKeyProvider()
    
    private init(minimumFetchInterval: Double = 0.0) {
        self.remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = minimumFetchInterval
        self.remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
    }
    
    func  isEnabled(_ flag: FeatureFlag) -> Bool {
        remoteConfig[flag.rawValue].boolValue
    }
    
    func value(for value: AdjustValue) -> Int {
        Int(truncating: remoteConfig[value.rawValue].numberValue)
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
