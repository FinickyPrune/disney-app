import Foundation
import Swinject
import SwinjectAutoregistration

final class ServicesAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(GenericAPI.self, initializer: Client.init)

        if FeatureFlagProvider.shared.isEnabled(.isUserMocked) {
            container.autoregister(
                UserRepository.self,
                initializer: UserRepositoryMock.init
            )
        } else {
            container.autoregister(
                UserRepository.self,
                initializer: UserRepositoryImpl.init
            )
        }

        if FeatureFlagProvider.shared.isEnabled(.isDisneyCharacters) {
            container.autoregister(
                CharactersRepository.self,
                initializer: DisneyCharactersRepository.init
            )
        } else {
            container.autoregister(
                CharactersRepository.self,
                initializer: NarutoCharactersRepository.init
            )
        }
    }
}
