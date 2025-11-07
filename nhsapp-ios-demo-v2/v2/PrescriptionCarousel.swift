import SwiftUI

struct PrescriptionCarousel: View {
    let prescriptions: [Prescription]
    var onSelect: (Prescription) -> Void
    
    private let spacing: CGFloat = 16
    
    var body: some View {
        GeometryReader { geo in
            let cardWidth = geo.size.width * 0.66
            
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
                .padding(.horizontal, 16)
            }
            .scrollTargetBehavior(.viewAligned)
        }
        .frame(height: 200) // Adjust height to match card
    }
}


#Preview {
    PrescriptionCarousel(
        prescriptions: [
            Prescription(name: "Ramipril", details: "5mg tablets", date: "18 Oct 2025", status: "Ready to collect"),
            Prescription(name: "Atorvastatin", details: "20mg tablets", date: "10 Sep 2025", status: "In progress")
        ]
    ) { _ in }
}
