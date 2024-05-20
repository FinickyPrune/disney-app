import Foundation
import FirebaseRemoteConfig

protocol RemoteConfigService {
    func fetchAndActivateConfig() async
    func bool(forKey key: RemoteConfigKey) -> Bool
}

final class RemoteConfigServiceImpl: RemoteConfigService {

    init(minimumFetchInterval: Double = 0.0) {
        self.remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = minimumFetchInterval
        self.remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
    }

    func fetchAndActivateConfig() async {
        do {
            try await self.remoteConfig.fetchAndActivate()
        } catch {
            print(error.localizedDescription)
        }
    }

    func bool(forKey key: RemoteConfigKey) -> Bool {
        self.remoteConfig[key.rawValue].boolValue
    }

    private let remoteConfig: RemoteConfig
}

// MARK: - RemoteConfigKey

enum RemoteConfigKey: String {
    case isAlternativeMode = "is_alternative_mode"
}
