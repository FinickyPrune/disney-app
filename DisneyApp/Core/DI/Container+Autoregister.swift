import UIKit
import Swinject
import SwinjectAutoregistration

extension Container {

    func registerCoordinators() {
        self.autoregister(
            Coordinator.self,
            argument: UINavigationController.self,
            initializer: Coordinator.init
        )
    }

    func registerRepositories() {
        self.autoregister(GenericAPI.self, initializer: Client.init)

        if FeatureFlag.isUserRemote {
            self.autoregister(
                UserRepository.self,
                initializer: UserRepositoryImpl.init
            )
        } else {
            self.autoregister(
                UserRepository.self,
                initializer: UserRepositoryMock.init
            )
        }

        if MainAssembly.shared.remoteConfigService.bool(forKey: .isAlternativeMode) {
            self.autoregister(
                CharactersRepository.self,
                initializer: NarutoCharactersRepository.init
            )
        } else {
            self.autoregister(
                CharactersRepository.self,
                initializer: DisneyCharactersRepository.init
            )
        }

    }

    func registerStores() {
        self.autoregister(
            CharactersListViewStore.self,
            initializer: CharactersListViewStore.init
        )
    }

    func registerViews() {
        self.autoregister(
            CharactersListView.self,
            initializer: CharactersListView.init
        )
    }

}
