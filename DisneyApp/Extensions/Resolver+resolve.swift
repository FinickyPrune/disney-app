import Foundation
import Swinject

extension Resolver {
    func resolve<T>(_ type: T.Type) -> T {
        self.resolve(T.self)!
    }
}
