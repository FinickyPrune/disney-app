import Foundation
import UIKit
import Swinject

final class MainAssembly {

    static let shared: MainAssembly = MainAssembly()

    private(set) lazy var container: Container = {
        let container = Container()

        container.registerCoordinators()
        container.registerRepositories()
        container.registerStores()
        container.registerViews()

        return container
    }()

    private(set) lazy var remoteConfigService: RemoteConfigService = {
        return RemoteConfigServiceImpl()
    }()
}

private extension Container {

    func registerCoordinators() {
        self.register(Coordinator.self) { _, navigationController in
            return Coordinator(navigationController: navigationController)
        }
    }

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

    func registerStores() {
        self.register(CharactersListViewStore.self) { resolver in
            return CharactersListViewStore(
                userRepository: resolver.resolve(UserRepository.self),
                charactersRepository: resolver.resolve(CharactersRepository.self)
            )
        }
    }

    func registerViews() {
        self.register(CharactersListView.self) { resolver in
            return CharactersListView(
                viewStore: resolver.resolve(CharactersListViewStore.self)
            )
        }
    }

}

private extension Resolver {
    func resolve<T>(_ type: T.Type) -> T {
        self.resolve(T.self)!
    }
}
