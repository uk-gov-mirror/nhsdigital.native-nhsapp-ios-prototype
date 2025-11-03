import SwiftUI

// MARK: - Flow Data Model
@Observable
class EmergencyPrescriptionFlowData {
    var selectedPharmacy: PharmacyOption = .wellcare
    var selectedMedicines: Set<MedicineOption> = []
    var emergencyReason: String = ""
}

// MARK: - Supporting Types
// Note: PharmacyOption and MedicineOption enums are shared with PrescriptionOrderView
// Make sure those enums are declared in a shared file or in the original PrescriptionOrderView

// MARK: - Flow step 1: Start screen
struct EmergencyPrescriptionOrderStep1View: View {
    @State private var flowData = EmergencyPrescriptionFlowData()
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationStack {
            EmergencyPrescriptionOrderStep1ContentView(flowData: flowData, isPresented: $isPresented)
        }
    }
}

struct EmergencyPrescriptionOrderStep1ContentView: View {
    @State var flowData: EmergencyPrescriptionFlowData
    @Binding var isPresented: Bool
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Request an emergency prescription")
                    .font(.largeTitle)
                    .bold()
                    .fixedSize(horizontal: false, vertical: true)
            
                Text("Use this service to request a limited emergency supply of a medicine you've completely run out of.")
                    .font(.title2)
                
                Text("This must be a medicine you are prescribed regularly, through a repeat prescription.")
                    .font(.body)
                    
                Text("You will be charged your usual prescription fee. If you do not usually pay, it will be free.")
                    .font(.body)
                    
                // Inset text component
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.nhsBlue)
                        .frame(width: 8)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Emergency prescription")
                            .font(.headline)
                        
                        Text("Emergency prescriptions are for urgent medical needs only. Your GP will review your request as a priority. Please provide a clear explanation of why this is an emergency.")
                            .font(.body)
                    }
                    .padding(.leading, 16)
                }
                
                Divider()

                Text("For life-threatening emergencies, call 999. For urgent medical advice, call 111 or visit 111.nhs.uk")
                    .font(.body)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .safeAreaInset(edge: .bottom) {
            NavigationLink(destination: EmergencyPrescriptionOrderStep2View(flowData: flowData, isPresented: $isPresented)) {
                Text("Start now")
                    .frame(maxWidth: .infinity)
                    .fontWeight(.semibold)
            }
            .buttonStyle(.glass)
            .controlSize(.large)
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(red: 0.933, green: 0.922, blue: 0.949))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    print("DEBUG: X button tapped, setting isPresented to false")
                    isPresented = false
                }) {
                    Image(systemName: "xmark")
                        .accessibilityLabel("Close")
                }
            }
        }
        .environment(flowData)
    }
}

// MARK: - Flow step 2: Emergency reason
struct EmergencyPrescriptionOrderStep2View: View {
    @State var flowData: EmergencyPrescriptionFlowData
    @Binding var isPresented: Bool
    @State private var emergencyReason: String = ""
    @State private var showCloseAlert = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Why is this an emergency?")
                    .font(.title)
                    .bold()
                    .fixedSize(horizontal: false, vertical: true)
                
                Text("Please explain why you need this prescription urgently. This information helps your GP prioritize your request.")
                    .font(.body)
                    .foregroundColor(.secondary)
                
                TextEditor(text: $emergencyReason)
                    .frame(minHeight: 150)
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(emergencyReason.isEmpty ? Color.nhsGrey4.opacity(0.5) : Color.nhsGrey4, lineWidth: 1)
                    )
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .safeAreaInset(edge: .bottom) {
            NavigationLink(destination: EmergencyPrescriptionOrderStep3View(flowData: flowData, isPresented: $isPresented)) {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .fontWeight(.semibold)
            }
            .buttonStyle(.glass)
            .controlSize(.large)
            .disabled(emergencyReason.isEmpty)
            .simultaneousGesture(TapGesture().onEnded {
                flowData.emergencyReason = emergencyReason
            })
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(red: 0.933, green: 0.922, blue: 0.949))
        .environment(flowData)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    showCloseAlert = true
                }) {
                    Image(systemName: "xmark")
                        .accessibilityLabel("Close")
                }
            }
        }
        .alert("Are you sure you want to close this form?", isPresented: $showCloseAlert) {
            Button("Continue with form", role: .cancel) { }
            Button("Exit form", role: .destructive) {
                isPresented = false
            }
        } message: {
            Text("Your progress will not be saved.")
        }
        .onAppear {
            emergencyReason = flowData.emergencyReason
        }
    }
}

// MARK: - Flow step 3: Current pharmacy with option to change
struct EmergencyPrescriptionOrderStep3View: View {
    @State var flowData: EmergencyPrescriptionFlowData
    @Binding var isPresented: Bool
    @State private var showChangePharmacy = false
    @State private var showCloseAlert = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Text("Your pharmacy")
                    .font(.title)
                    .bold()
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal)
                    .padding(.top)
                
                Text("Your emergency prescription will be sent to this pharmacy.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                    .padding(.top, 8)
                
                VStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(flowData.selectedPharmacy.name)
                            .foregroundColor(.nhsBlack)
                            .font(.body)
                            .bold()
                        Text(flowData.selectedPharmacy.address)
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.white)
                    
                    Divider()
                        .padding(.horizontal)
                    
                    Button(action: {
                        showChangePharmacy = true
                    }) {
                        HStack {
                            Text("Change pharmacy")
                                .foregroundColor(.nhsBlue)
                                .font(.body)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.nhsBlue)
                        }
                        .contentShape(Rectangle())
                        .padding()
                    }
                    .buttonStyle(.plain)
                    .background(Color.white)
                }
                .background(Color.white)
                .cornerRadius(30)
                .padding(.horizontal)
                .padding(.top, 20)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .safeAreaInset(edge: .bottom) {
            NavigationLink(destination: EmergencyPrescriptionOrderStep4View(flowData: flowData, isPresented: $isPresented)) {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .fontWeight(.semibold)
            }
            .buttonStyle(.glass)
            .controlSize(.large)
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(red: 0.933, green: 0.922, blue: 0.949))
        .environment(flowData)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    showCloseAlert = true
                }) {
                    Image(systemName: "xmark")
                        .accessibilityLabel("Close")
                }
            }
        }
        .alert("Are you sure you want to close this form?", isPresented: $showCloseAlert) {
            Button("Continue with form", role: .cancel) { }
            Button("Exit form", role: .destructive) {
                isPresented = false
            }
        } message: {
            Text("Your progress will not be saved.")
        }
        .sheet(isPresented: $showChangePharmacy) {
            EmergencyChangePharmacySheet(flowData: flowData, isPresented: $showChangePharmacy)
        }
    }
}

// MARK: - Change pharmacy sheet
struct EmergencyChangePharmacySheet: View {
    @State var flowData: EmergencyPrescriptionFlowData
    @Binding var isPresented: Bool
    @State private var selectedPharmacy: PharmacyOption?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Select your pharmacy")
                        .font(.title)
                        .bold()
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    Text("Your emergency prescription will be sent to this pharmacy.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                        .padding(.top, 8)
                    
                    VStack(spacing: 0) {
                        ForEach(PharmacyOption.allCases) { option in
                            Button(action: {
                                selectedPharmacy = option
                            }) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(option.name)
                                            .foregroundColor(.nhsBlack)
                                            .font(.body)
                                        Text(option.address)
                                            .foregroundColor(.secondary)
                                            .font(.subheadline)
                                    }
                                    
                                    Spacer()
                                    
                                    if selectedPharmacy == option {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(Color("NHSGreen"))
                                    }
                                }
                                .contentShape(Rectangle())
                                .padding()
                            }
                            .buttonStyle(.plain)
                            .background(Color.white)
                            
                            if option != PharmacyOption.allCases.last {
                                Divider()
                                    .padding(.horizontal)
                            }
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(30)
                    .padding(.horizontal)
                    .padding(.top, 20)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .safeAreaInset(edge: .bottom) {
                Button(action: {
                    if let pharmacy = selectedPharmacy {
                        flowData.selectedPharmacy = pharmacy
                        isPresented = false
                    }
                }) {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                        .fontWeight(.semibold)
                }
                .buttonStyle(.glass)
                .controlSize(.large)
                .disabled(selectedPharmacy == nil)
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(red: 0.933, green: 0.922, blue: 0.949))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "xmark")
                            .accessibilityLabel("Close")
                    }
                }
            }
            .onAppear {
                selectedPharmacy = flowData.selectedPharmacy
            }
        }
    }
}

// Continue with remaining views using the same pattern...

// MARK: - Flow step 4: Select medicines
struct EmergencyPrescriptionOrderStep4View: View {
    @State var flowData: EmergencyPrescriptionFlowData
    @Binding var isPresented: Bool
    @State private var selectedMedicines: Set<MedicineOption> = []
    @State private var showCloseAlert = false
    
    var allMedicinesSelected: Bool {
        selectedMedicines.count == MedicineOption.allCases.count
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Text("Which medicines do you need urgently?")
                    .font(.title)
                    .bold()
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal)
                    .padding(.top)
                
                Text("Select the medicines you need for your emergency prescription.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                    .padding(.top, 8)
                
                VStack(spacing: 0) {
                    // Select all option
                    HStack {
                        Text("Select all")
                            .foregroundColor(.nhsBlack)
                            .font(.body)
                            .bold()
                        
                        Spacer()
                        
                        Toggle("", isOn: Binding(
                            get: { allMedicinesSelected },
                            set: { isOn in
                                if isOn {
                                    selectedMedicines = Set(MedicineOption.allCases)
                                } else {
                                    selectedMedicines.removeAll()
                                }
                            }
                        ))
                        .labelsHidden()
                        .tint(Color.nhsGreen)
                    }
                    .padding()
                    .background(Color.white)
                    
                    Divider()
                        .padding(.horizontal)
                    
                    // Individual medicines
                    ForEach(MedicineOption.allCases) { option in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(option.name)
                                    .foregroundColor(.nhsBlack)
                                    .font(.body)
                                Text(option.details)
                                    .foregroundColor(.secondary)
                                    .font(.subheadline)
                            }
                            
                            Spacer()
                            
                            Toggle("", isOn: Binding(
                                get: { selectedMedicines.contains(option) },
                                set: { isOn in
                                    if isOn {
                                        selectedMedicines.insert(option)
                                    } else {
                                        selectedMedicines.remove(option)
                                    }
                                }
                            ))
                            .labelsHidden()
                            .tint(Color.nhsGreen)
                        }
                        .padding()
                        .background(Color.white)
                        
                        if option != MedicineOption.allCases.last {
                            Divider()
                                .padding(.horizontal)
                        }
                    }
                }
                .background(Color.white)
                .cornerRadius(30)
                .padding(.horizontal)
                .padding(.top, 20)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .safeAreaInset(edge: .bottom) {
            NavigationLink(destination: EmergencyPrescriptionOrderStep5View(flowData: flowData, isPresented: $isPresented)) {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .fontWeight(.semibold)
            }
            .buttonStyle(.glass)
            .controlSize(.large)
            .disabled(selectedMedicines.isEmpty)
            .simultaneousGesture(TapGesture().onEnded {
                flowData.selectedMedicines = selectedMedicines
            })
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(red: 0.933, green: 0.922, blue: 0.949))
        .environment(flowData)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    showCloseAlert = true
                }) {
                    Image(systemName: "xmark")
                        .accessibilityLabel("Close")
                }
            }
        }
        .alert("Are you sure you want to close this form?", isPresented: $showCloseAlert) {
            Button("Continue with form", role: .cancel) { }
            Button("Exit form", role: .destructive) {
                isPresented = false
            }
        } message: {
            Text("Your progress will not be saved.")
        }
        .onAppear {
            selectedMedicines = flowData.selectedMedicines
        }
    }
}

// MARK: - Flow step 5: Confirm details
struct EmergencyPrescriptionOrderStep5View: View {
    @State var flowData: EmergencyPrescriptionFlowData
    @Binding var isPresented: Bool
    @State private var showEditEmergencyReason = false
    @State private var showEditPharmacy = false
    @State private var showEditMedicines = false
    @State private var showCloseAlert = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Confirm your emergency request")
                    .font(.title)
                    .bold()
                    .fixedSize(horizontal: false, vertical: true)
                
                VStack(alignment: .leading, spacing: 0) {
                    Button(action: {
                        showEditEmergencyReason = true
                    }) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Emergency reason")
                                    .font(.body)
                                    .bold()
                                    .foregroundColor(.gray)
                                Text(flowData.emergencyReason)
                                    .font(.body)
                                    .foregroundColor(.nhsBlack)
                                    .lineLimit(2)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.primary.opacity(0.7))
                        }
                        .contentShape(Rectangle())
                        .padding(.vertical, 12)
                    }
                    .buttonStyle(.plain)
                    
                    Divider()
                    
                    Button(action: {
                        showEditPharmacy = true
                    }) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Pharmacy")
                                    .font(.body)
                                    .bold()
                                    .foregroundColor(.gray)
                                Text(flowData.selectedPharmacy.name)
                                    .font(.body)
                                    .foregroundColor(.nhsBlack)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.primary.opacity(0.7))
                        }
                        .contentShape(Rectangle())
                        .padding(.vertical, 12)
                    }
                    .buttonStyle(.plain)
                    
                    Divider()
                    
                    Button(action: {
                        showEditMedicines = true
                    }) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Medicines")
                                    .font(.body)
                                    .bold()
                                    .foregroundColor(.gray)
                                VStack(alignment: .leading, spacing: 2) {
                                    ForEach(Array(flowData.selectedMedicines).sorted(by: { $0.name < $1.name }), id: \.self) { medicine in
                                        Text(medicine.name)
                                            .font(.body)
                                            .foregroundColor(.nhsBlack)
                                    }
                                }
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.primary.opacity(0.7))
                        }
                        .contentShape(Rectangle())
                        .padding(.vertical, 12)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal)
                .background(Color.white)
                .cornerRadius(30)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .safeAreaInset(edge: .bottom) {
            NavigationLink(destination: EmergencyPrescriptionOrderStep6View(flowData: flowData, isPresented: $isPresented)) {
                Text("Submit emergency request")
                    .frame(maxWidth: .infinity)
                    .fontWeight(.semibold)
            }
            .buttonStyle(.glass)
            .controlSize(.large)
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(red: 0.933, green: 0.922, blue: 0.949))
        .environment(flowData)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    showCloseAlert = true
                }) {
                    Image(systemName: "xmark")
                        .accessibilityLabel("Close")
                }
            }
        }
        .alert("Are you sure you want to close this form?", isPresented: $showCloseAlert) {
            Button("Continue with form", role: .cancel) { }
            Button("Exit form", role: .destructive) {
                isPresented = false
            }
        } message: {
            Text("Your progress will not be saved.")
        }
        .sheet(isPresented: $showEditEmergencyReason) {
            EmergencyEditReasonSheet(flowData: flowData, isPresented: $showEditEmergencyReason)
        }
        .sheet(isPresented: $showEditPharmacy) {
            EmergencyChangePharmacySheet(flowData: flowData, isPresented: $showEditPharmacy)
        }
        .sheet(isPresented: $showEditMedicines) {
            EmergencyEditMedicinesSheet(flowData: flowData, isPresented: $showEditMedicines)
        }
    }
}

// MARK: - Edit Emergency Reason Sheet
struct EmergencyEditReasonSheet: View {
    @State var flowData: EmergencyPrescriptionFlowData
    @Binding var isPresented: Bool
    @State private var emergencyReason: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Why is this an emergency?")
                        .font(.title)
                        .bold()
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text("Please explain why you need this prescription urgently.")
                        .font(.body)
                        .foregroundColor(Color.nhsGrey1)
                    
                    TextEditor(text: $emergencyReason)
                        .frame(minHeight: 150)
                        .padding(16)
                        .background(Color.nhsWhite)
                        .cornerRadius(30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(emergencyReason.isEmpty ? Color.nhsGrey4.opacity(0.5) : Color.nhsGrey4, lineWidth: 1)
                        )
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .safeAreaInset(edge: .bottom) {
                Button(action: {
                    flowData.emergencyReason = emergencyReason
                    isPresented = false
                }) {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.glass)
                .controlSize(.large)
                .disabled(emergencyReason.isEmpty)
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(red: 0.933, green: 0.922, blue: 0.949))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "xmark")
                            .accessibilityLabel("Close")
                    }
                }
            }
            .onAppear {
                emergencyReason = flowData.emergencyReason
            }
        }
    }
}

// MARK: - Edit Medicines Sheet
struct EmergencyEditMedicinesSheet: View {
    @State var flowData: EmergencyPrescriptionFlowData
    @Binding var isPresented: Bool
    @State private var selectedMedicines: Set<MedicineOption> = []
    
    var allMedicinesSelected: Bool {
        selectedMedicines.count == MedicineOption.allCases.count
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Which medicines do you need urgently?")
                        .font(.title)
                        .bold()
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    Text("Select the medicines you need for your emergency prescription.")
                        .font(.body)
                        .foregroundColor(Color.nhsGrey1)
                        .padding(.horizontal)
                        .padding(.top, 8)
                    
                    VStack(spacing: 0) {
                        // Select all option
                        HStack {
                            Text("Select all")
                                .foregroundColor(.nhsBlack)
                                .font(.body)
                                .bold()
                            
                            Spacer()
                            
                            Toggle("", isOn: Binding(
                                get: { allMedicinesSelected },
                                set: { isOn in
                                    if isOn {
                                        selectedMedicines = Set(MedicineOption.allCases)
                                    } else {
                                        selectedMedicines.removeAll()
                                    }
                                }
                            ))
                            .labelsHidden()
                            .tint(Color.nhsGreen)
                        }
                        .padding()
                        .background(Color.nhsWhite)
                        
                        Divider()
                            .padding(.horizontal)
                        
                        // Individual medicines
                        ForEach(MedicineOption.allCases) { option in
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(option.name)
                                        .foregroundColor(.nhsBlack)
                                        .font(.body)
                                    Text(option.details)
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                }
                                
                                Spacer()
                                
                                Toggle("", isOn: Binding(
                                    get: { selectedMedicines.contains(option) },
                                    set: { isOn in
                                        if isOn {
                                            selectedMedicines.insert(option)
                                        } else {
                                            selectedMedicines.remove(option)
                                        }
                                    }
                                ))
                                .labelsHidden()
                                .tint(Color.nhsGreen)
                            }
                            .padding()
                            .background(Color.nhsWhite)
                            
                            if option != MedicineOption.allCases.last {
                                Divider()
                                    .padding(.horizontal)
                            }
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(30)
                    .padding(.horizontal)
                    .padding(.top, 20)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .safeAreaInset(edge: .bottom) {
                Button(action: {
                    flowData.selectedMedicines = selectedMedicines
                    isPresented = false
                }) {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.glass)
                .controlSize(.large)
                .disabled(selectedMedicines.isEmpty)
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(red: 0.933, green: 0.922, blue: 0.949))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "xmark")
                            .accessibilityLabel("Close")
                    }
                }
            }
            .onAppear {
                selectedMedicines = flowData.selectedMedicines
            }
        }
    }
}

// MARK: - Flow step 6: Request confirmed
struct EmergencyPrescriptionOrderStep6View: View {
    @State var flowData: EmergencyPrescriptionFlowData
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text("Your emergency prescription has been requested")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.nhsWhite)
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.vertical)
                        .background(Color("NHSPurple"))
                        .cornerRadius(30)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 16)
                    .padding(.top, 20)
                    
                    VStack(alignment: .leading, spacing: 24) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("What happens next")
                                .font(.title3)
                                .bold()
                            
                            Text("Your emergency request has been sent to your GP surgery and will be reviewed as a priority. Your GP may contact you to discuss your urgent request. Once approved, your prescription will be sent to the pharmacy.")
                                .font(.body)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 8)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Your emergency request details")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.nhsBlack)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Emergency reason")
                                        .font(.subheadline)
                                        .foregroundColor(Color.nhsGrey1)
                                    Text(flowData.emergencyReason)
                                        .font(.body)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Your chosen pharmacy")
                                        .font(.subheadline)
                                        .foregroundColor(Color.nhsGrey1)
                                    Text(flowData.selectedPharmacy.name)
                                        .font(.body)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Medicines")
                                        .font(.subheadline)
                                        .foregroundColor(Color.nhsGrey1)
                                    VStack(alignment: .leading, spacing: 2) {
                                        ForEach(Array(flowData.selectedMedicines).sorted(by: { $0.name < $1.name }), id: \.self) { medicine in
                                            Text(medicine.name)
                                                .font(.body)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 8)
                            .padding(.bottom, 16)
                        }
                        .padding(.top, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(30)
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .background(Color(red: 0.933, green: 0.922, blue: 0.949))
        .environment(flowData)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    isPresented = false
                }) {
                    Text("Done")
                        .fontWeight(.semibold)
                }
                .buttonStyle(.borderedProminent)
                .tint(.nhsGreen)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        PrescriptionsView()
    }
}
