import SwiftUI

struct PrescriptionsView: View {
    
    private let samplePrescriptions = Prescription.activeSampleData
    @State private var showPrescription = false
    
    var body: some View {
        ZStack {
            
            // Full page background
            Color("NHSGrey5")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    
                    // MARK: Header Title + View All
                    NavigationLink {
                        PrescriptionProgressView()
                    } label: {
                        HStack {
                            Text("Your prescriptions")
                                .font(.headline)
                                .foregroundColor(Color("NHSBlack"))
                            
                            Spacer()
                            
                            HStack(spacing: 4) {
                                Text("View all")
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundColor(Color("AccentColor"))
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(Color("AccentColor"))
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .contentShape(Rectangle())
                    }
                    .accessibilityLabel("Your prescriptions: View all")
                    .accessibilityHint("Opens the full prescriptions list")
                    .padding(.top, 16)
                    
                    // MARK: Carousel
                    PrescriptionCarousel(
                        prescriptions: samplePrescriptions
                    ) { _ in
                        showPrescription = true
                    }
                    .padding(.top, 8)
                    
                    // MARK: List
                    List {
                        
                        Section {
                            RowLink {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Your chosen pharmacy")
                                        .bold()
                                    Text("Wellcare Pharmacy")
                                        .foregroundStyle(.textSecondary)
                                }
                                .padding(.vertical, 4)
                            } destination: {
                                DetailView(index: 0)
                            }
                            .accessibilityElement(children: .combine)
                            .accessibilityLabel("Your chosen pharmacy, Wellcare Pharmacy")
                            .accessibilityHint("Double tap to change your pharmacy")
                        }
                        .rowStyle(.white)
                        
                        Section {
                            RowLink(title: "Request a repeat prescription") { DetailView(index: 0) }
                            RowLink(title: "Medicines record") { DetailView(index: 0) }
                            RowLink(title: "Request an emergency prescription") { DetailView(index: 0) }
                        } header: {
                            Text("GP surgery")
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
                    .background(Color.clear)
                    .frame(minHeight: 600)
                    .padding(.top, -24) // Pull list closer to carousel
                }
            }
            // ✅ Improves whole-screen accessibility grouping
            .accessibilityElement(children: .contain)
        }
        .navigationTitle("Prescriptions")
        .navigationBarTitleDisplayMode(.large)
        .fullScreenCover(isPresented: $showPrescription) {
            PrescriptionDetailView()
        }
    }
}

#Preview {
    NavigationStack {
        PrescriptionsView()
    }
}
