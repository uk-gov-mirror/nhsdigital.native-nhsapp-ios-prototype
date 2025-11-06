import SwiftUI

struct PrescriptionsView: View {
    
    @State private var showPrescription = false
    @State private var showPrescriptionCard = true

    var body: some View {
        List {
            
            Section {
                VStack(alignment: .leading, spacing: 16) {
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
                        
                        PrescriptionIcon(scale:1)
                            .padding(.top, 4)
                    }
                    
                    Divider()
                        .overlay(Color("NHSAppDarkGreen").opacity(0.2))
                    
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
            } header: {
                Text("In progress")
            }
            .rowStyle(.paleGreen)
            .contentShape(Rectangle())
            .onTapGesture {
                showPrescription = true
            }
            
            RowLink(title: "View all prescriptions") { PrescriptionProgressView() }
                .rowStyle(.white)

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
        .navigationTitle("Prescriptions")
        .navigationBarTitleDisplayMode(.large)
        .nhsListStyle()
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
