import SwiftUI

struct PrescriptionsView: View {
    
    private let samplePrescriptions = Prescription.activeSampleData
    
    @State private var showPrescription = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                // MARK: Header Title + View All
                HStack {
                    Text("Your prescriptions")
                        .font(.headline)
                        .foregroundColor(Color("NHSBlack"))
                        .padding(.leading, 16)
                    
                    Spacer()
                    
                    NavigationLink {
                        PrescriptionProgressView()
                    } label: {
                        HStack(spacing: 4) {
                            Text("View all")
                                .font(.subheadline)
                                .bold()
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 12, weight: .semibold))
                        }
                        .foregroundColor(Color("AccentColor"))
                        .padding(.vertical, 8)
                        .contentShape(Rectangle())
                    }
                    .padding(.trailing, 16)
                    .accessibilityLabel("View all prescriptions")
                    .accessibilityHint("Opens the full prescriptions list")
                }
                .padding(.top, 16)
                
                
                // MARK: Edge-to-edge carousel
                PrescriptionCarousel(
                    prescriptions: samplePrescriptions
                ) { _ in
                    showPrescription = true
                }
                .padding(.top, 8)
                
                
                // MARK: List content
                List {
                    Section {
                        RowLink(title: "Request a repeat prescription") { DetailView(index: 0) }
                        RowLink(title: "Medicines record") { DetailView(index: 0) }
                        RowLink(title: "Request an emergency prescription") { DetailView(index: 0) }
                    } header: {
                        Text("GP surgery")
                    }
                    .rowStyle(.white)
                    
                    RowLink {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Your chosen pharmacy")
                            Text("Wellcare Pharmacy")
                                .font(.subheadline)
                                .foregroundStyle(.textSecondary)
                        }
                        .padding(.vertical, 4)
                    } destination: {
                        DetailView(index: 0)
                    }
                    .rowStyle(.white)
                    
                    Section {
                        RowLink(title: "Hospital and other medicines") { DetailView(index: 0) }
                    } header: {
                        Text("Hospital")
                    }
                    .rowStyle(.white)
                }
                .nhsListStyle()
                .scrollContentBackground(.hidden)
                .background(Color("pageBackground"))
                .frame(minHeight: 600)
            }
        }
        .background(Color("pageBackground"))
        .navigationTitle("Prescriptions")
        .navigationBarTitleDisplayMode(.large)
        .fullScreenCover(isPresented: $showPrescription) {
            PrescriptionDetailView()
        }
    }
}


// MARK: Preview
#Preview {
    NavigationStack {
        PrescriptionsView()
    }
}
