import SwiftUI

struct PrescriptionCard: View {
    let prescription: Prescription

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {

                    // Prescription type
                    Text(prescription.type.rawValue)
                        .bold()
                        .font(.footnote)
                        .padding(.bottom, 4)
                        .foregroundStyle(Color("NHSBlack"))

                    // MARK: Main medicine
                    if let first = prescription.medicines.first {
                        Text(first.name)
                            .font(.body.bold())
                            .foregroundStyle(Color("NHSBlack"))

                        Text(first.dosage)
                            .font(.footnote)
                            .foregroundStyle(Color("NHSBlack"))
                    }

                    // MARK: "X more medicine(s)" OR placeholder
                    // let extraCount = prescription.medicines.count - 1
                    // Group {
                    //     if extraCount > 0 {
                    //         Text(extraCount == 1 ?
                    //              "1 more medicine" :
                    //              "\(extraCount) more medicines")
                    //     } else {
                    //         Text("X more medicines")
                    //             .hidden()   // ✅ reserve space
                    //     }
                    // }
                    // .font(.footnote)
                    // .foregroundStyle(Color(.textSecondary))
                    // .padding(.top, 2)

                    // Prescribed date
                    Text("Prescribed on \(prescription.date)")
                        .font(.footnote)
                        .foregroundStyle(Color("NHSBlack"))
                        .padding(.top, 8)
                }

                Spacer()

                PrescriptionIcon(scale: 1)
                    .padding(.top, 4)
            }

            Divider()
                .overlay(Color("NHSAppDarkGreen").opacity(0.2))

            HStack(spacing: 8) {
                Image(systemName: iconForStatus)
                    .font(.system(size: 12))
                    .foregroundColor(statusColor)
                    .accessibilityHidden(true)

                Text(prescription.status)
                    .foregroundColor(statusColor)
                    .font(.subheadline.bold())
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color("NHSAppPaleGreen"))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    // MARK: Icons + colours
    private var iconForStatus: String {
        if prescription.status.contains("Collected") { return "checkmark.circle.fill" }
        if prescription.status.contains("Ready") { return "circle.fill" }
        return "hourglass"
    }

    private var statusColor: Color {
        if prescription.status.contains("Collected") { return Color("NHSGreen") }
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
}
