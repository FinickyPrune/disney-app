import Foundation

protocol ConfigKey {}

enum FeatureFlag: String, ConfigKey {
    case isUserMocked
    case isDisneyCharacters
    case isHaveMaxCharactersCount
}

enum AdjustValue: String, ConfigKey {
    case charactersNumber
}
