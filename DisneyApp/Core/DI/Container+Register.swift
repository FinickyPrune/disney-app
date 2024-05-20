import UIKit
import Swinject

extension Container {

    func registerRepositories() {
        self.register(GenericAPI.self) { _ in
            return Client()
        }

        self.register(UserRepository.self) { resolver in
            if FeatureFlag.isUserRemote {
                return UserRepositoryImpl(
                    client: resolver.resolve(GenericAPI.self)
                )
            }
            return UserRepositoryMock()
        }

        self.register(CharactersRepository.self) { resolver in
            if MainAssembly.shared.remoteConfigService.bool(forKey: .isAlternativeMode) {
                return NarutoCharactersRepository(
                    client: resolver.resolve(GenericAPI.self)
                )
            }
            return DisneyCharactersRepository(
                client: resolver.resolve(GenericAPI.self)
            )
        }
    }

}
