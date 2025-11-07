import SwiftUI

struct PrescriptionCarousel: View {
    let prescriptions: [Prescription]
    var onSelect: (Prescription) -> Void
    
    private let spacing: CGFloat = 16
    
    var body: some View {
        GeometryReader { geo in
            let cardWidth = geo.size.width * 0.66 // Size of the card
            let sidePadding: CGFloat = 24   // Adds "peeking"
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: spacing) {
                    ForEach(prescriptions) { prescription in
                        PrescriptionCard(prescription: prescription)
                            .frame(width: cardWidth)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                onSelect(prescription)
                            }
                    }
                }
                // ✅ Snapping
                .scrollTargetLayout()
            }
            // ✅ Snap cards
            .scrollTargetBehavior(.viewAligned)
            
            // ✅ This creates the "peeking" effect
            .contentMargins(.horizontal, sidePadding, for: .scrollContent)
        }
        .frame(height: 200)
    }
}

#Preview {
    PrescriptionCarousel(
        prescriptions: Prescription.activeSampleData
    ) { _ in }
}
