import SwiftUI

struct PrescriptionsView: View {
    
    private let samplePrescriptions = Prescription.activeSampleData
    @State private var showPrescription = false
    
    var body: some View {
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
                    .padding(.top, 8)
                    .padding(.bottom, 16)
                    .contentShape(Rectangle())
                }
                .accessibilityLabel("Your prescriptions: View all")
                .accessibilityHint("Opens the full prescriptions list")
                
                // MARK: Carousel
                PrescriptionCarousel(
                    prescriptions: samplePrescriptions
                ) { _ in
                    showPrescription = true
                }
                
                VStack(spacing: 24) {
                    
                    // MARK: Pharmacy Section
                    VStack(spacing: 0) {
                        NavigationLink {
                            DetailView(index: 0)
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Your chosen pharmacy")
                                        .font(.body.bold())
                                        .foregroundColor(.text)
                                    Text("Wellcare Pharmacy")
                                        .font(.body)
                                        .foregroundStyle(.textSecondary)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color("NHSGrey2"))
                            }
                            .padding()
                            .background(Color("NHSWhite"))
                            .cornerRadius(24)
                        }
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("Your chosen pharmacy, Wellcare Pharmacy")
                        .accessibilityHint("Double tap to change your pharmacy")
                    }
                    .padding(.horizontal, 16)
                    
                    // MARK: GP Surgery Section
                    VStack(alignment: .leading, spacing: 32) {
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("GP surgery")
                                .font(.body.bold())
                                .padding(.leading, 32)
                            
                            VStack(spacing: 1) {
                                NavigationLink {
                                    DetailView(index: 0)
                                } label: {
                                    MenuRow(title: "Request a repeat prescription")
                                }
                                
                                Divider()
                                    .frame(height: 1)
                                    .overlay(Color("NHSGrey4"))
                                    .padding(.leading, 16)
                                    .padding(.trailing, 16)
                                
                                NavigationLink {
                                    DetailView(index: 0)
                                } label: {
                                    MenuRow(title: "Medicines record")
                                }
                                
                                Divider()
                                    .frame(height: 1)
                                    .overlay(Color("NHSGrey4"))
                                    .padding(.leading, 16)
                                    .padding(.trailing, 16)
                                    
                                NavigationLink {
                                    DetailView(index: 0)
                                } label: {
                                    MenuRow(title: "Request an emergency prescription")
                                }
                            }
                            .background(Color("NHSWhite"))
                            .cornerRadius(24)
                            .padding(.horizontal, 16)
                        }
                    }
                    
                    // MARK: Hospital Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Hospital")
                            .font(.body.bold())
                            .padding(.leading, 32)
                        
                        NavigationLink {
                            DetailView(index: 0)
                        } label: {
                            MenuRow(title: "Hospital and other medicines")
                        }
                        .background(Color("NHSWhite"))
                        .cornerRadius(24)
                        .padding(.horizontal, 16)
                    }
                    
                    // Bottom padding
                    Spacer(minLength: 20)
                }
                .padding(.top, 16)
            }
        }
        .background(Color("NHSGrey5"))
        .navigationTitle("Prescriptions")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showPrescription) {
            PrescriptionDetailView()
        }
    }
}

// Helper view for menu rows
struct MenuRow: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.body)
                .foregroundColor(Color("NHSBlack"))
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14))
                .foregroundColor(Color("NHSGrey2"))
        }
        .padding()
        .contentShape(Rectangle())
    }
}

#Preview {
    NavigationStack {
        PrescriptionsView()
    }
}
