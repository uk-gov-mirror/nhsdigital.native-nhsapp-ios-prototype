import SwiftUI

struct PrescriptionProgressView: View {
    
    @State private var showPrescription = false
    @State private var selectedTab = 0   // 0 = Active, 1 = Past
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: Segmented Control
            Picker("Prescription Type", selection: $selectedTab) {
                Text("Active").tag(0)
                Text("Past").tag(1)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            .controlSize(.large)
            
            // MARK: List of prescriptions
            List {
                if selectedTab == 0 {
                    prescriptionSection(Prescription.activeSampleData)
                } else {
                    prescriptionSection(Prescription.pastSampleData)
                }
            }
            .nhsListStyle()
            .sheet(isPresented: $showPrescription) {
                PrescriptionDetailView()
            }
        }
        .background(Color("NHSGrey5").ignoresSafeArea())
        .navigationTitle("Your prescriptions")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    // MARK: Reusable Section builder
    private func prescriptionSection(_ prescriptions: [Prescription]) -> some View {
        ForEach(prescriptions) { prescription in
            Section {
                PrescriptionCard(prescription: prescription)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        showPrescription = true
                    }
            }
            .rowStyle(.paleGreen)
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
        }
    }
}

#Preview {
    NavigationStack {
        PrescriptionProgressView()
    }
}
