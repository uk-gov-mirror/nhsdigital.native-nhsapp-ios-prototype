import SwiftUI

struct PrescriptionCarousel: View {
    let prescriptions: [Prescription]
    var onSelect: (Prescription) -> Void

    private let spacing: CGFloat = 10

    var body: some View {
        GeometryReader { geo in
            let cardWidth = geo.size.width * 0.66
            let leadingPadding: CGFloat = 16
            let trailingPeekPadding: CGFloat = 0

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: spacing) {
                    ForEach(Array(prescriptions.enumerated()), id: \.element.id) { index, prescription in

                        let medicinesSummary = prescription.medicines
                            .map { "\($0.name) \($0.dosage)" }
                            .joined(separator: ", ")

                        let accessibilityLabel =
                            "\(prescription.type.rawValue). " +
                            "Medicines: \(medicinesSummary). " +
                            "Status: \(prescription.status). " +
                            "\(index + 1) of \(prescriptions.count)"

                        PrescriptionCard(prescription: prescription)
                            .frame(width: cardWidth)
                            .contentShape(Rectangle())
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel(accessibilityLabel)
                            .accessibilityHint("Double tap to view prescription details")
                            .accessibilityAddTraits(.isButton)
                            .onTapGesture { onSelect(prescription) }
                    }

                    // peeking on the right
                    Spacer().frame(width: trailingPeekPadding)
                }
            }
            .contentMargins(.leading, leadingPadding, for: .scrollContent)
            .accessibilityElement(children: .contain)
            .accessibilityLabel("Your prescriptions carousel")
            .accessibilityHint("Swipe left or right to browse your prescriptions")
        }
        .frame(height: 240)
    }
}

#Preview {
    PrescriptionCarousel(
        prescriptions: Prescription.activeSampleData
    ) { _ in }
}
