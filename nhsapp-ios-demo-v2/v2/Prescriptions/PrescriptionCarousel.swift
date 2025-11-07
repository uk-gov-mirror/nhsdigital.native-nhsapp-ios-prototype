import SwiftUI

struct PrescriptionCarousel: View {
    let prescriptions: [Prescription]
    var onSelect: (Prescription) -> Void

    private let spacing: CGFloat = 10

    var body: some View {
        GeometryReader { geo in
            let cardWidth = geo.size.width * 0.66
            let leadingPadding: CGFloat = 16        // Aligns with heading
            let trailingPeekPadding: CGFloat = 48   // How much of next card should peek

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: spacing) {
                    ForEach(Array(prescriptions.enumerated()), id: \.element.id) { index, prescription in
                        PrescriptionCard(prescription: prescription)
                            .frame(width: cardWidth)
                            .contentShape(Rectangle())

                            // Accessibility
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel("\(prescription.name), \(prescription.details). Status: \(prescription.status). \(index + 1) of \(prescriptions.count)")
                            .accessibilityHint("Double tap to view prescription details")
                            .accessibilityAddTraits(.isButton)

                            .onTapGesture {
                                onSelect(prescription)
                            }
                    }

                    // This keeps the peek on the right
                    Spacer().frame(width: trailingPeekPadding)
                }
                .scrollTargetLayout()     // Enable snapping
            }
            .scrollTargetBehavior(.viewAligned)

            // Leading alignment only
            .contentMargins(.leading, leadingPadding, for: .scrollContent)

            // Carousel-level accessibility
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
