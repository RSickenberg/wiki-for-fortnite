// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
internal enum L10n {

  internal enum Details {
    /// Base
    internal static let base = L10n.tr("Localizable", "details.base")
    /// Capactiy
    internal static let capacity = L10n.tr("Localizable", "details.capacity")
    /// Crouching
    internal static let crouching = L10n.tr("Localizable", "details.crouching")
    /// Damages
    internal static let damages = L10n.tr("Localizable", "details.damages")
    /// Damages + Head
    internal static let damagesHead = L10n.tr("Localizable", "details.damages&Head")
    /// Delay
    internal static let delay = L10n.tr("Localizable", "details.delay")
    /// Details
    internal static let details = L10n.tr("Localizable", "details.details")
    /// Downsights
    internal static let downsights = L10n.tr("Localizable", "details.downsights")
    /// DPS
    internal static let dps = L10n.tr("Localizable", "details.dps")
    /// Environmental damages
    internal static let envDmgs = L10n.tr("Localizable", "details.env_dmgs")
    /// Fire rate
    internal static let fireRate = L10n.tr("Localizable", "details.fire_rate")
    /// Horizontal
    internal static let horizontal = L10n.tr("Localizable", "details.horizontal")
    /// Impact
    internal static let impact = L10n.tr("Localizable", "details.impact")
    /// Jump & Fall
    internal static let jumpFall = L10n.tr("Localizable", "details.jump_fall")
    /// Locations
    internal static let locations = L10n.tr("Localizable", "details.locations")
    /// Magazine size
    internal static let magazine = L10n.tr("Localizable", "details.magazine")
    /// Angle max
    internal static let maxAngle = L10n.tr("Localizable", "details.max_angle")
    /// Angle min
    internal static let minAngle = L10n.tr("Localizable", "details.min_angle")
    /// Note
    internal static let note = L10n.tr("Localizable", "details.note")
    /// Overall
    internal static let overall = L10n.tr("Localizable", "details.overall")
    /// Recoil
    internal static let recoil = L10n.tr("Localizable", "details.recoil")
    /// Reload time
    internal static let reload = L10n.tr("Localizable", "details.reload")
    /// Spread
    internal static let spread = L10n.tr("Localizable", "details.spread")
    /// Sprint
    internal static let sprint = L10n.tr("Localizable", "details.sprint")
    /// Vertical
    internal static let vertical = L10n.tr("Localizable", "details.vertical")
  }

  internal enum Dislike {
    /// You can check other stuff.
    internal static let more = L10n.tr("Localizable", "dislike.more")
    /// It's okay.
    internal static let title = L10n.tr("Localizable", "dislike.title")
  }

  internal enum Like {
    /// You can see your favorites on the Favorites tab.
    internal static let more = L10n.tr("Localizable", "like.more")
    /// It's liked!
    internal static let title = L10n.tr("Localizable", "like.title")
  }

  internal enum Market {
    /// Data may be limited.
    internal static let disclamer = L10n.tr("Localizable", "market.disclamer")
  }

  internal enum Navigation {
    /// Favorites
    internal static let favorites = L10n.tr("Localizable", "navigation.favorites")
    /// Market
    internal static let market = L10n.tr("Localizable", "navigation.market")
  }

  internal enum Rarety {
    /// Atypical
    internal static let atypical = L10n.tr("Localizable", "rarety.atypical")
    /// Common
    internal static let common = L10n.tr("Localizable", "rarety.common")
    /// Epic
    internal static let epic = L10n.tr("Localizable", "rarety.epic")
    /// Legendary
    internal static let legendary = L10n.tr("Localizable", "rarety.legendary")
    /// Rare
    internal static let rare = L10n.tr("Localizable", "rarety.rare")
  }

  internal enum Title {
    /// Items
    internal static let item = L10n.tr("Localizable", "title.item")
    /// Weapons
    internal static let weapon = L10n.tr("Localizable", "title.weapon")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
