import Foundation
import Swinject
import SwinjectAutoregistration

final class ServicesAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(GenericAPI.self, initializer: Client.init)

        if ConfigKeyProvider.shared.isEnabled(.isUserMocked) {
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
        
        var charactersMaxCount: Int?
        if ConfigKeyProvider.shared.isEnabled(.isHaveMaxCharactersCount) {
            charactersMaxCount = ConfigKeyProvider.shared.value(for: .charactersNumber)
        }

        if ConfigKeyProvider.shared.isEnabled(.isDisneyCharacters) {
            container.autoregister(
                CharactersRepository.self,
                initializer: {
                    DisneyCharactersRepository(
                        client: container.resolve(GenericAPI.self),
                        charactersMaxCount: charactersMaxCount
                    )
                }
            )
        } else {
            container.autoregister(
                CharactersRepository.self,
                initializer: {
                    NarutoCharactersRepository(
                        client: container.resolve(GenericAPI.self),
                        charactersMaxCount: charactersMaxCount
                    )
                }
            )
        }
    }
}
