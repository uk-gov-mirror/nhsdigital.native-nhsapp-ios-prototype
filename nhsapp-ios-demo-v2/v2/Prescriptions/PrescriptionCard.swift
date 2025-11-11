import SwiftUI

struct PrescriptionCard: View {
    let prescription: Prescription
    var isPast: Bool = false
    
    var defaultAccessibilityLabel: String {
        var parts: [String] = []

        parts.append(prescription.type.rawValue)

        if let first = prescription.medicines.first {
            parts.append("\(first.name), \(first.dosage)")
        }

        parts.append("Prescribed on \(prescription.date)")

        // Optional improvement: make past items more natural
        // if isPast {
        //     parts.append(prescription.status)
        // } else {
        //     parts.append("Status: \(prescription.status)")
        // }

        parts.append("Status: \(prescription.status)")
        
        return parts.joined(separator: ". ")
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {

                    Text(prescription.type.rawValue)
                        .font(.footnote.bold())
                        .padding(.bottom, 4)
                        .foregroundStyle(Color("NHSBlack"))

                    if let first = prescription.medicines.first {
                        Text(first.name)
                            .font(.body.bold())
                            .foregroundStyle(Color("NHSBlack"))
                            .lineLimit(nil)

                        Text(first.dosage)
                            .font(.footnote)
                            .foregroundStyle(Color("NHSBlack"))
                            .lineLimit(nil)
                    }

                    Text("Prescribed on \(prescription.date)")
                        .font(.footnote)
                        .foregroundStyle(Color("NHSBlack"))
                        .padding(.top, 8)
                        .lineLimit(nil)
                }

                Spacer()

                PrescriptionIcon(scale: 1)
                    .padding(.top, 4)
                    .accessibilityHidden(true)
            }

            Divider()
                .overlay(Color("NHSAppDarkGreen").opacity(0.2))

            HStack(spacing: 8) {
                Image(systemName: iconForStatus)
                    .font(.caption)
                    .foregroundColor(statusColor)
                    .accessibilityHidden(true)

                Text(prescription.status)
                    .foregroundColor(statusColor)
                    .font(.subheadline.bold())
                    .lineLimit(nil)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(isPast ? Color("NHSWhite") : Color(.prescriptionGreen))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .accessibilityElement(children: .combine)
        .accessibilityLabel(defaultAccessibilityLabel)
        .accessibilityHint("Double tap to view prescription details")
    }

    private var iconForStatus: String {
        if prescription.status.contains("Collected") { return "checkmark" }
        if prescription.status.contains("Ready") { return "circle.fill" }
        return "hourglass"
    }

    private var statusColor: Color {
        if prescription.status.contains("Collected") { return Color("NHSGrey1") }
        if prescription.status.contains("Ready") { return Color("NHSGreen") }
        return Color("NHSAppDarkBlue")
    }
}

#Preview {
    PrescriptionCard(
        prescription: Prescription(
            medicines: [
                Medicine(name: "Ramipril", dosage: "5mg tablets"),
                Medicine(name: "Amlodipine", dosage: "10mg tablets"),
                Medicine(name: "Atorvastatin", dosage: "20mg tablets")
            ],
            date: "18 Oct 2025",
            status: "Ready to collect",
            type: .repeatPrescription
        )
    )
    .padding()
    
    PrescriptionCard(
        prescription: Prescription(
            medicines: [
                Medicine(name: "Atorvastatin", dosage: "20mg tablets")
            ],
            date: "18 Oct 2025",
            status: "Pending",
            type: .repeatPrescription
        )
    )
    .padding()
    
    PrescriptionCard(
        prescription: Prescription(
            medicines: [
                Medicine(name: "Atorvastatin", dosage: "20mg tablets")
            ],
            date: "18 Oct 2025",
            status: "Collected",
            type: .repeatPrescription
        )
    )
    .padding()
}
