import SwiftUI

struct PrescriptionDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 16) {
  
                        HStack(spacing: 8) {
                            Image(systemName: "circle.fill")
                                .foregroundColor(Color("NHSGreen"))
                                .font(.system(size: 14))
                            
                            Text("Ready to collect")
                                .foregroundColor(Color("NHSAppDarkGreen"))
                                .font(.headline)
                                .bold()
                        }
                        
                        Divider()
                            .overlay(Color("NHSAppDarkGreen").opacity(0.2))
                        
                        Text("Medicines")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(Color("NHSBlack"))
                        
                        HStack {
                            Text("Amoxicillin")
                                .bold()
                            Spacer()
                            Text("500mg capsules")
                        }
                        
                        HStack {
                            Text("Amoxicillin")
                                .bold()
                            Spacer()
                            Text("500mg capsules")
                        }
                        
                        Text("For instructions on how to take your medicine, read the label on the packet or container.")
                            .foregroundStyle(Color("NHSBlack"))
                        
                        Divider()
                            .overlay(Color("NHSAppDarkGreen").opacity(0.2))
                        
                        HStack {
                            Text("Date prescribed")
                                .bold()
                            Spacer()
                            Text("18 July 2024")
                        }
                        
                        Divider()
                            .overlay(Color("NHSAppDarkGreen").opacity(0.2))
                        
                        HStack {
                            Text("Prescribed by")
                                .bold()
                            Spacer()
                            Text("Dr. Smith")
                        }
                        
                        Divider()
                            .overlay(Color("NHSAppDarkGreen").opacity(0.2))
                        
                        HStack {
                            Text("Organisation")
                                .bold()
                            Spacer()
                            Text("York Road Practice")
                        }
                        
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
