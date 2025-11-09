import SwiftUI

struct PrescriptionProgressView: View {
    
    @State private var showPrescription = false
    @State private var selectedTab = 0   // 0 = Active, 1 = Past

    // ✅ Accessibility focus targets
    @AccessibilityFocusState private var focusActive: Bool
    @AccessibilityFocusState private var focusPast: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: Segmented Control
            Picker("Prescription Type", selection: $selectedTab) {
                Text("Active").tag(0)
                Text("Past").tag(1)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            .padding(.bottom, 8)
            .controlSize(.large)
            .onChange(of: selectedTab) { _, _ in
                withAnimation(.easeInOut(duration: 0.25)) { }

                // ✅ VoiceOver announcement
                UIAccessibility.post(
                    notification: .announcement,
                    argument: selectedTab == 0 ? "Active prescriptions" : "Past prescriptions"
                )

                // ✅ Move focus to the new hidden header
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    if selectedTab == 0 {
                        focusActive = true
                    } else {
                        focusPast = true
                    }
                }
            }
            
            // MARK: Animated sliding pages
            GeometryReader { geo in
                HStack(spacing: 0) {
                    
                    // ✅ Active page (NO white rectangle – header moved outside list)
                    VStack(spacing: 0) {
                        Text("Active prescriptions")
                            .hidden()                         // not visible
                            .accessibilityHidden(false)       // but accessible
                            .accessibilityAddTraits(.isHeader)
                            .accessibilityFocused($focusActive)
                            .frame(height: 0)                 // no space

                        List {
                            prescriptionSection(Prescription.activeSampleData)
                        }
                        .nhsListStyle()
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
                        .sheet(isPresented: $showPrescription) {
                            PrescriptionDetailView()
                        }
                    }
                    .frame(width: geo.size.width)
                    
                    // ✅ Past page (same fix)
                    VStack(spacing: 0) {
                        Text("Past prescriptions")
                            .hidden()
                            .accessibilityHidden(false)
                            .accessibilityAddTraits(.isHeader)
                            .accessibilityFocused($focusPast)
                            .frame(height: 0)

                        List {
                            prescriptionSection(Prescription.pastSampleData)
                        }
                        .nhsListStyle()
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
                        .sheet(isPresented: $showPrescription) {
                            PrescriptionDetailView()
                        }
                    }
                    .frame(width: geo.size.width)
                }
                .offset(x: -CGFloat(selectedTab) * geo.size.width)
                .animation(.easeInOut(duration: 0.25), value: selectedTab)
            }
        }
        .background(Color("NHSGrey5").ignoresSafeArea())
        .navigationTitle("Your prescriptions")
        .navigationBarTitleDisplayMode(.inline)
        
        // MARK: Swipe gestures (left/right)
        .gesture(
            DragGesture()
                .onEnded { value in
                    let width = value.translation.width
                    
                    if width < -60 && selectedTab == 0 {
                        selectedTab = 1
                    } else if width > 60 && selectedTab == 1 {
                        selectedTab = 0
                    }
                }
        )
    }
    
    
    // MARK: Section builder
    private func prescriptionSection(_ prescriptions: [Prescription]) -> some View {
        ForEach(prescriptions) { prescription in
            Section {
                PrescriptionCard(prescription: prescription)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        showPrescription = true
                    }
            }
            .rowStyle(.paleGreen)
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
        }
    }
}

#Preview {
    NavigationStack {
        PrescriptionProgressView()
    }
}
