import SwiftUI

struct PrescriptionsView: View {
    
    @State private var showPrescriptionCard = true
    @State private var showPrescriptionOrderFlow = false
    @State private var showEmergencyPrescriptionOrderFlow = false

    var body: some View {
        List {
            
            // Prescription card - dismissable
            if showPrescriptionCard {
                Section {
                    ZStack(alignment: .topTrailing) {
                            
                        HStack(alignment: .center) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Ready to collect")
                                    .font(.body)
                                    .bold()
                                Text("Ramipril 50mg | Order 557579689")
                            }
                            Spacer(minLength: 40)
                        }

                        Button {
                            withAnimation(.easeInOut) {
                                showPrescriptionCard = false
                            }
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title2)
                                .foregroundColor(Color("NHSAppDarkPurple"))
                                .accessibilityLabel("Dismiss prescription card")
                        }
                        .accessibilityLabel("Dismiss prescription card")
                        .accessibilityHint("Hides the 'Ready to collect' message.")
                        
                    }
                    RowLink(title: "View prescription") { DetailView(index: 0) }
                }
                .rowStyle(.palePurple)
                .transition(.move(edge: .top).combined(with: .opacity))
            }

            Section {

                Button(action: {
                    showPrescriptionOrderFlow = true
                }) {
                    HStack {
                        Text("Request an repeat prescription")
                            .foregroundColor(.nhsBlack)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.primary.opacity(0.7))
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                
                RowLink(title: "Check the progress of prescriptions") { PrescriptionsRequestView()
                }
                RowLink(title: "Medicines record") { DetailView(index: 0) }
                
                // Emergency prescription button - opens separate flow
                Button(action: {
                    showEmergencyPrescriptionOrderFlow = true
                }) {
                    HStack {
                        Text("Request an emergency prescription")
                            .foregroundColor(.nhsBlack)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.primary.opacity(0.7))
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                
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
        .fullScreenCover(isPresented: $showPrescriptionOrderFlow) {
            PrescriptionOrderStep1View(isPresented: $showPrescriptionOrderFlow)
        }
        .fullScreenCover(isPresented: $showEmergencyPrescriptionOrderFlow) {
            EmergencyPrescriptionOrderStep1View(isPresented: $showEmergencyPrescriptionOrderFlow)
        }
    }
}

#Preview {
    NavigationStack {
        PrescriptionsView()
    }
}
