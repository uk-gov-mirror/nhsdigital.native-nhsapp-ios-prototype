import SwiftUI

extension View {
    /// Adds a toolbar button labeled "App help" to the top-right of the navigation bar.
    func appHelpToolbar() -> some View {
        self.toolbar {
            // Help button
            ToolbarItem(placement: .topBarTrailing) {
                Button("App help") {}
            }
        }
    }
}
