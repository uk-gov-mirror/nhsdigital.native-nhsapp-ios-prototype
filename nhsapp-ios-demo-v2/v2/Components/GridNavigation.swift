import SwiftUI

// Simplified grid button that just takes an action
struct SimpleGridNavigationButton: View {
    let title: String
    let systemImage: String
    let action: () -> Void
    
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    @ScaledMetric(relativeTo: .body) private var iconSize: CGFloat = 28
    @ScaledMetric(relativeTo: .body) private var padding: CGFloat = 16
    @ScaledMetric(relativeTo: .body) private var iconBottomPadding: CGFloat = 4
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: iconBottomPadding) {
                Image(systemName: systemImage)
                    .font(.system(size: iconSize))
                    .foregroundColor(Color("AccentColor"))
                    .accessibilityHidden(true)
                    .padding(.top, 4)
                
                Spacer(minLength: 4)
                
                HStack(alignment: .bottom) {
                    Text(title)
                        .font(.body)
                        .foregroundColor(.text)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(nil)
                    
                    Spacer(minLength: 8)
                    
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(Color("NHSGrey2"))
                        .padding(.bottom, 3)
                        .accessibilityHidden(true)
                }
            }
            .padding(padding)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .background(Color("NHSWhite"))
            .cornerRadius(24)
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel(title)
        .accessibilityHint("Double tap to open \(title)")
        .accessibilityAddTraits(.isButton)
        .accessibilityRemoveTraits(.isImage)
    }
}
