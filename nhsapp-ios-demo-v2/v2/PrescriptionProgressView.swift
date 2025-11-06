import SwiftUI

struct PrescriptionProgressView: View {
    
    @State private var showPrescription = false

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
            }
            .rowStyle(.paleGreen)
            .contentShape(Rectangle()) // Makes entire area tappable
            .onTapGesture {
                showPrescription = true
            }
            .fullScreenCover(isPresented: $showPrescription) {
                // Your sheet content here
                PrescriptionDetailView()
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
            .contentShape(Rectangle()) // Makes entire area tappable
            .onTapGesture {
                showPrescription = true
            }
            .fullScreenCover(isPresented: $showPrescription) {
                // Your sheet content here
                PrescriptionDetailView()
            }

        }
        .navigationTitle("Prescriptions")
        .navigationBarTitleDisplayMode(.large)
        .nhsListStyle()
    }
}

#Preview {
    NavigationStack {
        PrescriptionProgressView()
    }
}
