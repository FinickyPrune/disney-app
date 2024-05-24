import Foundation

protocol ConfigKey where Self: RawRepresentable, Self.RawValue == String {}

enum FeatureFlag: String, ConfigKey {
    case isUserMocked
    case isDisneyCharacters
    case isHaveMaxCharactersCount
}

enum AdjustValue: String, ConfigKey {
    case charactersNumber
}
