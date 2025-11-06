import SwiftUI

struct PrescriptionIcon: View {
    var scale: CGFloat = 1.0  // Default scale
    
    var spacing: CGFloat { 4 * scale }
    var circleSize: CGFloat { 6 * scale }
    
    var body: some View {
        VStack(spacing: spacing) {
            ForEach(0..<3) { _ in
                HStack(spacing: spacing) {
                    ForEach(0..<3) { _ in
                        Circle()
                            .fill(Color("NHSGreen").opacity(0.3))
                            .frame(width: circleSize, height: circleSize)
                    }
                }
            }
        }
        .accessibilityHidden(true)
    }
}

