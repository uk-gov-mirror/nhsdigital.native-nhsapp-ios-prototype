import SwiftUI

struct PrescriptionList: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.text)
            .buttonStyle(NHSButtonTextStyle())
            .toggleStyle(NHSToggleStyle())
            .listSectionSpacing(20)
            .scrollContentBackground(.hidden)
            .background(Color(.prescriptionGreen))
    }
}

extension View {
    func prescriptionList() -> some View {
        modifier(PrescriptionList())
    }
}

#Preview {
    HomeView()
}
