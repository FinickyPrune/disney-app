import Foundation
import Swinject

extension Container {
    func resolve<T>(_ type: T.Type) -> T {
        self.resolve(T.self)!
    }
}

