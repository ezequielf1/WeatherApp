// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Weather app
  internal static let appName = L10n.tr("Localizable", "app_name")
  /// The app only works with location authorization. Please enable it to be able to view the information.
  internal static let appOnlyWorksWithLocationAuth = L10n.tr("Localizable", "app_only_works_with_location_auth")
  /// Check out the weather
  internal static let checkOutTheWeather = L10n.tr("Localizable", "check_out_the_weather")
  /// Connection error
  internal static let connectionError = L10n.tr("Localizable", "connection_error")
  /// Decoding error
  internal static let decodingError = L10n.tr("Localizable", "decoding_error")
  /// Empty response error
  internal static let emptyResponseError = L10n.tr("Localizable", "empty_response_error")
  /// Error
  internal static let error = L10n.tr("Localizable", "error")
  /// Forecast
  internal static let forecast = L10n.tr("Localizable", "forecast")
  /// Malformed url
  internal static let malformedUrl = L10n.tr("Localizable", "malformed_url")
  /// Ok
  internal static let ok = L10n.tr("Localizable", "ok")
  /// Share
  internal static let share = L10n.tr("Localizable", "share")
  /// Timeout error
  internal static let timeoutError = L10n.tr("Localizable", "timeout_error")
  /// Today
  internal static let today = L10n.tr("Localizable", "today")
  /// The user location is not available
  internal static let userLocationNotAvailable = L10n.tr("Localizable", "user_location_not_available")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
