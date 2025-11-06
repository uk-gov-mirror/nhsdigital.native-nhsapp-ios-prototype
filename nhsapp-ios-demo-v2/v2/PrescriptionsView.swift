import SwiftUI

struct PrescriptionsView: View {
    
    @State private var showPrescription = false
    @State private var showPrescriptionCard = true

    var body: some View {
        List {
            
            // Prescription card (no persistence; shows after delay on each appearance)
            if showPrescriptionCard {
                Section {
                    ZStack(alignment: .topTrailing) {
                            
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Repeat prescription")
                                    .bold()
                                    .font(.footnote)
                                    .padding(.bottom, 4)
                                Text("Ramipril")
                                    .font(.body)
                                    .bold()
                                    .foregroundStyle(Color("NHSBlack"))
                                Text("5mg tablets")
                                    .font(.footnote)
                                    .foregroundStyle(Color("NHSBlack"))
                                Text("Prescribed on 18 Oct 2025")
                                    .font(.footnote)
                                    .foregroundStyle(Color("NHSBlack"))
                                    .padding(.top, 8)
                            }
                            Spacer()
                        }

                        Button {
                            withAnimation(.easeInOut) {
                                showPrescriptionCard = false
                            }
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title2)
                                .foregroundColor(Color("NHSAppDarkGreen"))
                                .accessibilityLabel("Dismiss prescription")
                        }
                        .accessibilityLabel("Dismiss prescription")
                        .accessibilityHint("Hides the ‘Prescription is ready to collect’ message.")
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 8) {
                            Image(systemName: "circle.fill")
                                .foregroundColor(Color("NHSGreen"))
                                .font(.system(size: 12))
                            
                            Text("Ready to collect")
                                .foregroundColor(Color("NHSAppDarkGreen"))
                                .font(.subheadline)
                                .bold()
                        }
                        
                    }
                }
                .rowStyle(.paleGreen)
                .contentShape(Rectangle()) // Makes entire area tappable
                .onTapGesture {
                    showPrescription = true
                }
                .fullScreenCover(isPresented: $showPrescription) {
                    PrescriptionDetailView()
                }
                .transition(.move(edge: .top).combined(with: .opacity))
            }

            Section {
                RowLink(title: "Request a repeat prescription") { DetailView(index: 0) }
                RowLink(title: "Check the progress of prescriptions") { PrescriptionProgressView() }
                RowLink(title: "Medicines record") { DetailView(index: 0) }
                RowLink(title: "Request an emergency prescription") { DetailView(index: 0) }
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
        .navigationTitle("Prescriptions")
        .navigationBarTitleDisplayMode(.large)
        .nhsListStyle()
    }
}

#Preview {
    NavigationStack {
        PrescriptionsView()
    }
}
