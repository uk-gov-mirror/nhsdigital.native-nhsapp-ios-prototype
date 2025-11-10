import SwiftUI

struct PrescriptionDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List {
                
                HStack(spacing: 8) {
                    Image(systemName: "circle.fill")
                        .foregroundColor(Color("NHSGreen"))
                        .font(.system(size: 14))
                    
                    Text("Ready to collect")
                        .foregroundColor(Color("NHSGreen"))
                        .font(.headline)
                        .bold()
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                
                Section {
                    VStack {
                        Text("Show this barcode at the pharmacy to collect your prescription")
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(.textSecondary))
                            .padding(.vertical, 8)
                        
                        Image("barcode")
                            .resizable()
                            .frame(height: 100)
                    }
                }
                .rowStyle(.prescription)
                
                Section {
                    VStack (alignment: .leading) {

                        Text("Boots Pharmacy")
                            .font(.body.bold())
                        
                        Text("123 High Street, London SW1 1AA")
                            .font(.body)
                            .foregroundStyle(.textSecondary)
                            .padding(.bottom, 8)
                        
                        Divider()
                            .padding(.bottom, 8)
                        
                        NHSButton(title: "Find my pharmacy", style: .primary) { }
                    }
                }
                .rowStyle(.prescription)
                
                Section {
                    
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
                        .font(.subheadline)
                    
                }
                .rowStyle(.prescription)
                
                Section {
                    HStack {
                        Text("Date prescribed")
                            .font(.subheadline.bold())
                        Spacer()
                        Text("18 July 2024")
                            .font(.subheadline)
                    }
                    
                    HStack {
                        Text("Prescribed by")
                            .font(.subheadline.bold())
                        Spacer()
                        Text("Dr. Smith")
                            .font(.subheadline)
                    }
                    
                    HStack {
                        Text("Organisation")
                            .font(.subheadline.bold())
                        Spacer()
                        Text("York Road Practice")
                            .font(.subheadline)
                    }
                }
                .rowStyle(.prescription)
                
                NHSButton(title: "Contact GP surgery", style: .secondary) { }
                        
            }
            .prescriptionList()
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
