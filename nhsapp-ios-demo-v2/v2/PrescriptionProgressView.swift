import SwiftUI

struct PrescriptionProgressView: View {
    
    @State private var showPrescription = false
    @State private var selectedTab = 0 // 0 for Active, 1 for Past
    
    var body: some View {
        VStack(spacing: 0) {
            // Segmented Control
            Picker("Prescription Type", selection: $selectedTab) {
                Text("Active").tag(0)
                Text("Past").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(.thinMaterial)
            
            List {
                if selectedTab == 0 {
                    // Active Prescriptions
                    activePrescritionsContent
                } else {
                    // Past Prescriptions
                    pastPrescriptionsContent
                }
            }
            .nhsListStyle()
            .fullScreenCover(isPresented: $showPrescription) {
                PrescriptionDetailView()
            }
        }
        .navigationTitle("Your prescriptions")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Active prescriptions view
    @ViewBuilder
    private var activePrescritionsContent: some View {
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
        }
        .rowStyle(.paleGreen)
        .contentShape(Rectangle())
        .onTapGesture {
            showPrescription = true
        }
        
        Section {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("One off prescription")
                            .bold()
                            .font(.footnote)
                            .padding(.bottom, 4)
                        Text("Amoxicillin")
                            .font(.body)
                            .bold()
                            .foregroundStyle(Color("NHSBlack"))
                        Text("500mg capsules")
                            .font(.footnote)
                            .foregroundStyle(Color("NHSBlack"))
                            .padding(.bottom, 4)
                        Text("Diclofenac")
                            .font(.body)
                            .bold()
                            .foregroundStyle(Color("NHSBlack"))
                        Text("50mg tablets")
                            .font(.footnote)
                            .foregroundStyle(Color("NHSBlack"))
                        Text("Prescribed on 12 Oct 2025")
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
                        Image(systemName: "hourglass")
                            .foregroundColor(Color("NHSAppDarkBlue"))
                            .font(.system(size: 16))
                        
                        Text("Pending")
                            .foregroundColor(Color("NHSAppDarkBlue"))
                            .font(.subheadline)
                            .bold()
                    }
                }
            }
        }
        .rowStyle(.paleGreen)
        .contentShape(Rectangle())
        .onTapGesture {
            showPrescription = true
        }
    }
    
    // Past prescriptions view
    @ViewBuilder
    private var pastPrescriptionsContent: some View {
        Section {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Repeat prescription")
                            .bold()
                            .font(.footnote)
                            .padding(.bottom, 4)
                        Text("Omeprazole")
                            .font(.body)
                            .bold()
                            .foregroundStyle(Color("NHSBlack"))
                        Text("20mg capsules")
                            .font(.footnote)
                            .foregroundStyle(Color("NHSBlack"))
                        Text("Prescribed on 15 Sep 2025")
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
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color("NHSGreen"))
                            .font(.system(size: 12))
                        
                        Text("Collected on 20 Sep 2025")
                            .foregroundColor(Color("NHSAppDarkGreen"))
                            .font(.subheadline)
                            .bold()
                    }
                }
            }
        }
        .rowStyle(.paleGreen)
        .contentShape(Rectangle())
        .onTapGesture {
            showPrescription = true
        }
        
        Section {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("One off prescription")
                            .bold()
                            .font(.footnote)
                            .padding(.bottom, 4)
                        Text("Prednisolone")
                            .font(.body)
                            .bold()
                            .foregroundStyle(Color("NHSBlack"))
                        Text("5mg tablets")
                            .font(.footnote)
                            .foregroundStyle(Color("NHSBlack"))
                        Text("Prescribed on 01 Aug 2025")
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
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color("NHSGreen"))
                            .font(.system(size: 12))
                        
                        Text("Collected on 05 Aug 2025")
                            .foregroundColor(Color("NHSAppDarkGreen"))
                            .font(.subheadline)
                            .bold()
                    }
                }
            }
        }
        .rowStyle(.paleGreen)
        .contentShape(Rectangle())
        .onTapGesture {
            showPrescription = true
        }
    }
}

#Preview {
    NavigationStack {
        PrescriptionProgressView()
    }
}
