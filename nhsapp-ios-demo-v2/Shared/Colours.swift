import SwiftUI
import DesignSystem

// Semantic color aliases (single allocation, auto-adapts via Asset variants)
extension Color {
    static let pageBackground   = Color(nhsColor: .grey5)
    static let text             = Color(nhsColor: .black)
    static let textSecondary    = Color(nhsColor: .grey1)
    static let textTertiary     = Color(nhsColor: .grey3)
    static let textInverse      = Color(nhsColor: .white)
    static let textInverseOnly  = Color(nhsColor: .whiteOnly)
    static let destructive      = Color(nhsColor: .red)
    static let warning          = Color(nhsColor: .orange)
    static let primary          = Color(nhsColor: .blue)
    static let textLink         = Color(nhsColor: .blue)
}

// Shorthands so you can write `.foregroundStyle(.text)` etc.
extension ShapeStyle where Self == Color {
    static var pageBackground: Color  { .pageBackground }
    static var text: Color            { .text }
    static var textSecondary: Color   { .textSecondary }
    static var textTertiary: Color    { .textTertiary }
    static var textInverse: Color     { .textInverse }
    static var textInverseOnly: Color { .textInverseOnly }
    static var destructive: Color     { .destructive }
    static var warning: Color         { .warning }
    static var primary: Color         { .primary }
    static var textLink: Color        { .textLink}
}
