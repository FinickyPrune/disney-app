import Foundation
import Swinject

extension Resolver {
    func resolve<T>(_ type: T.Type) -> T {
        self.resolve(T.self)!
    }
    
    func resolve<T>(_ type: T.Type, name: String) -> T {
        self.resolve(T.self, name: name)!
    }
    
    func resolve<T, Arg1>(_ type: T.Type, name: String, argument: Arg1) -> T {
        self.resolve(T.self, name: name, argument: argument)!
    }
}
