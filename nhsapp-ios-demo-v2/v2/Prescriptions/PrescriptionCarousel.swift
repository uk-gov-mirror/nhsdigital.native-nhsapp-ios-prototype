import SwiftUI

struct PrescriptionCarousel: View {
    let prescriptions: [Prescription]
    var onSelect: (Prescription) -> Void
    
    private let spacing: CGFloat = 16
    
    var body: some View {
        GeometryReader { geo in
            let cardWidth = geo.size.width * 0.66      // Size of each card
            let sidePadding: CGFloat = 24              // Peeking amount
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: spacing) {
                    ForEach(Array(prescriptions.enumerated()), id: \.element.id) { index, prescription in
                        
                        PrescriptionCard(prescription: prescription)
                            .frame(width: cardWidth)
                            .contentShape(Rectangle())
                            
                            // ✅ Accessibility
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel("\(prescription.name), \(prescription.details). Status: \(prescription.status). \(index + 1) of \(prescriptions.count)")
                            .accessibilityHint("Double tap to view prescription details")
                            .accessibilityAddTraits(.isButton)
                            
                            .onTapGesture {
                                onSelect(prescription)
                            }
                    }
                }
                // ✅ Snapping
                .scrollTargetLayout()
            }
            // ✅ Snap cards to alignment
            .scrollTargetBehavior(.viewAligned)
            
            // ✅ Peeking effect
            .contentMargins(.horizontal, sidePadding, for: .scrollContent)
            
            // ✅ Carousel-level accessibility
            .accessibilityElement(children: .contain)
            .accessibilityLabel("Your prescriptions carousel")
            .accessibilityHint("Swipe left or right to browse your prescriptions")
        }
        .frame(height: 200)
    }
}

#Preview {
    PrescriptionCarousel(
        prescriptions: Prescription.activeSampleData
    ) { _ in }
}
