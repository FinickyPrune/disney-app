import Foundation
import Swinject

final class MainAssembly {

    static let shared: MainAssembly = MainAssembly()

    private(set) lazy var container: Container = {
        let container = Container()

        container.registerRepositories()

        return container
    }()

    private(set) lazy var remoteConfigService: RemoteConfigService = {
        return RemoteConfigServiceImpl()
    }()
}

extension Resolver {
    func resolve<T>(_ type: T.Type) -> T {
        self.resolve(T.self)!
    }
}
