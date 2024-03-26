import Foundation

final class Client: GenericAPI {

    let session: URLSession

    init() {
        self.session = URLSession(configuration: .default)
    }
}
