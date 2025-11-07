import SwiftUI

struct PrescriptionCard: View {
    let prescription: Prescription

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Repeat prescription")
                        .bold()
                        .font(.footnote)
                        .padding(.bottom, 4)

                    Text(prescription.name)
                        .font(.body)
                        .bold()
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

            HStack(spacing: 8) {
                Image(systemName: "circle.fill")
                    .foregroundColor(Color("NHSGreen"))
                    .font(.system(size: 12))

                Text(prescription.status)
                    .foregroundColor(Color("NHSAppDarkGreen"))
                    .font(.subheadline)
                    .bold()
            }
        }
        .padding()
        .background(Color("NHSAppPaleGreen"))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    PrescriptionCard(
        prescription: Prescription(
            name: "Ramipril",
            details: "5mg tablets",
            date: "18 Oct 2025",
            status: "Ready to collect"
        )
    )
    .padding()
}
