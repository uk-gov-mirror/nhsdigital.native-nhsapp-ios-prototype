import SwiftUI

import SwiftUI

// MARK: - Reusable Card Style
struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color("NHSWhite"))
            .cornerRadius(24)
            .padding(.horizontal, 16)
    }
}

// MARK: - Section Header Style
struct SectionHeaderStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body.bold())
            .padding(.leading, 32)
    }
}

// MARK: - Custom Divider Component
struct CardDivider: View {
    var body: some View {
        Divider()
            .frame(height: 1)
            .overlay(Color("NHSGrey4"))
            .padding(.horizontal, 16)
    }
}

// MARK: - View Extensions
extension View {
    func cardStyle() -> some View {
        modifier(CardStyle())
    }
    
    func sectionHeaderStyle() -> some View {
        modifier(SectionHeaderStyle())
    }
}
