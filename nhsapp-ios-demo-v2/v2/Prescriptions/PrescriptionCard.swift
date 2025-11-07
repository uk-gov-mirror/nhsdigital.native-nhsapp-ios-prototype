import SwiftUI

struct PrescriptionCard: View {
    let prescription: Prescription

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    
                    // ✅ Type label (Repeat / One off)
                    Text(prescription.type.rawValue)
                        .bold()
                        .font(.footnote)
                        .padding(.bottom, 4)
                        .foregroundStyle(Color("NHSBlack"))

                    Text(prescription.name)
                        .font(.body.bold())
                        .foregroundStyle(Color("NHSBlack"))

                    Text(prescription.details)
                        .font(.footnote)
                        .foregroundStyle(Color("NHSBlack"))

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

            // ✅ Status row
            HStack(spacing: 8) {
                Image(systemName: iconForStatus)
                    .font(.system(size: 12))
                    .foregroundColor(statusColor)

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
    
    // MARK: Helpers
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
            name: "Ramipril",
            details: "5mg tablets",
            date: "18 Oct 2025",
            status: "Ready to collect",
            type: .repeatPrescription
        )
    )
    .padding()
}
