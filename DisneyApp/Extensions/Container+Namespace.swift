import UIKit
import Swinject

protocol NameSpacedResolver: Resolver {
    var charactersListViewName: String { get }
}

extension Container: NameSpacedResolver {
    var charactersListViewName: String { "CharactersListView" }
}
