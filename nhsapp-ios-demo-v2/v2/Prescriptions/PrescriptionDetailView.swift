import SwiftUI

struct PrescriptionDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 16) {
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Prescribed on 18 Oct 2025")
                                .font(.subheadline)
                                .foregroundStyle(Color.textSecondary)
                            
                            HStack(spacing: 8) {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(Color("NHSGreen"))
                                    .font(.system(size: 14))
                                
                                Text("Ready to collect")
                                    .foregroundColor(Color("NHSAppDarkGreen"))
                                    .font(.headline)
                                    .bold()
                            }
                        }
                        
                        Divider()
                            .overlay(Color("NHSAppDarkGreen").opacity(0.2))
                        
                        VStack(alignment: .leading, spacing: 8) {
                            VStack(alignment: .leading, spacing: 4) {
                                
                                Text("Amoxicillin")
                                    .font(.body)
                                    .bold()
                                    .foregroundStyle(Color("NHSBlack"))
                                Text("500mg capsules")
                                    .font(.footnote)
                                    .foregroundStyle(Color("NHSBlack"))
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Diclofenac")
                                    .font(.body)
                                    .bold()
                                    .foregroundStyle(Color("NHSBlack"))
                                Text("50mg tablets")
                                    .font(.footnote)
                                    .foregroundStyle(Color("NHSBlack"))
                            }
                        }
                        
                        Divider()
                            .overlay(Color("NHSAppDarkGreen").opacity(0.2))
                        
                    }
                        
                    .padding()
                }
            }
            .background(Color("NHSAppPaleGreen"))
            .navigationTitle("Repeat prescription")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 17, weight: .medium))
                    }
                    .accessibilityLabel("Close")
                }
            }
        }
    }
}

#Preview {
    PrescriptionDetailView()
}
