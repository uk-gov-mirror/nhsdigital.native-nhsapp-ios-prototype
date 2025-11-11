import SwiftUI

// PreferenceKey to track the maximum card size
struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        let next = nextValue()
        value.width = max(value.width, next.width)
        value.height = max(value.height, next.height)
    }
}

struct PrescriptionCarousel: View {
    let prescriptions: [Prescription]
    var onSelect: (Prescription) -> Void

    private let spacing: CGFloat = 10
    @State private var maxCardSize: CGSize = CGSize(width: 0, height: 240)
    @Environment(\.sizeCategory) var sizeCategory
    
    // Dynamic card width based on text size category
    private func cardWidth(for geometryWidth: CGFloat) -> CGFloat {
        switch sizeCategory {
        case .accessibilityMedium, .accessibilityLarge,
             .accessibilityExtraLarge, .accessibilityExtraExtraLarge,
             .accessibilityExtraExtraExtraLarge:
            // For accessibility sizes, show almost full width to prevent truncation
            return geometryWidth * 0.8
        case .extraExtraLarge, .extraExtraExtraLarge:
            return geometryWidth * 0.8
        case .extraLarge:
            return geometryWidth * 0.8
        case .large:
            return geometryWidth * 0.7
        default:
            return geometryWidth * 0.66
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            let cardWidth = cardWidth(for: geo.size.width)
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
                            // Allow the card to expand vertically as needed
                            .fixedSize(horizontal: false, vertical: true)
                            .background(
                                GeometryReader { geometry in
                                    Color.clear
                                        .preference(
                                            key: SizePreferenceKey.self,
                                            value: geometry.size
                                        )
                                }
                            )
                            .contentShape(Rectangle())
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel(accessibilityLabel)
                            .accessibilityHint("Double tap to view prescription details")
                            .accessibilityAddTraits(.isButton)
                            .onTapGesture { onSelect(prescription) }
                    }

                    // peeking on the right - only show if not in accessibility sizes
                    if !sizeCategory.isAccessibilityCategory {
                        Spacer().frame(width: trailingPeekPadding)
                    }
                }
            }
            .contentMargins(.leading, leadingPadding, for: .scrollContent)
            .onPreferenceChange(SizePreferenceKey.self) { size in
                // Add padding to ensure content isn't cut off
                let padding: CGFloat = sizeCategory.isAccessibilityCategory ? 40 : 20
                maxCardSize = CGSize(
                    width: size.width,
                    height: size.height + padding
                )
            }
            .accessibilityElement(children: .contain)
            .accessibilityLabel("Your prescriptions carousel")
            .accessibilityHint("Swipe left or right to browse your prescriptions")
        }
        .frame(height: maxCardSize.height)
        .animation(.easeInOut(duration: 0.2), value: maxCardSize.height)
    }
}

// Extension to check if size category is accessibility
extension ContentSizeCategory {
    var isAccessibilityCategory: Bool {
        switch self {
        case .accessibilityMedium, .accessibilityLarge,
             .accessibilityExtraLarge, .accessibilityExtraExtraLarge,
             .accessibilityExtraExtraExtraLarge:
            return true
        default:
            return false
        }
    }
}


#Preview {
    PrescriptionCarousel(
        prescriptions: Prescription.activeSampleData
    ) { _ in }
}
