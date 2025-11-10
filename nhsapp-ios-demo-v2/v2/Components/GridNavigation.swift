import SwiftUI

struct GridNavigationButton<Destination: View>: View {
    let title: String
    let systemImage: String
    @ViewBuilder let destination: () -> Destination
    @State private var navigate = false
    @Environment(\.isNavigated) private var isNavigated
    
    // Use @ScaledMetric to scale values with Dynamic Type
    @ScaledMetric(relativeTo: .body) private var iconSize: CGFloat = 28
    @ScaledMetric(relativeTo: .body) private var padding: CGFloat = 16
    @ScaledMetric(relativeTo: .body) private var iconBottomPadding: CGFloat = 4
    
    var body: some View {
        Button(action: {
            navigate = true
            isNavigated.wrappedValue = true
        }) {
            VStack(alignment: .leading, spacing: iconBottomPadding) {
                Image(systemName: systemImage)
                    .font(.system(size: iconSize))
                    .foregroundColor(Color("AccentColor"))
                    .accessibilityHidden(true)
                
                Spacer(minLength: 4)
                
                HStack(alignment: .bottom) {
                    Text(title)
                        .font(.body)
                        .foregroundColor(.text)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(nil)
                    
                    Spacer(minLength: 8)
                    
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(Color("NHSGrey2"))
                        .padding(.bottom, 3)
                        .accessibilityHidden(true)
                }
            }
            .padding(padding)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .background(Color("NHSWhite"))
            .cornerRadius(24)
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel(title)
        .accessibilityHint("Double tap to open \(title)")
        .accessibilityAddTraits(.isButton)
        .accessibilityRemoveTraits(.isImage)
        .navigationDestination(isPresented: $navigate) {
            destination()
                .onAppear {
                    isNavigated.wrappedValue = true
                }
        }
    }
}

#Preview {
    NavigationStack {
        List {
            Section {
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 12),
                    GridItem(.flexible(), spacing: 12)
                ], spacing: 12) {
                    GridNavigationButton(
                        title: "Prescriptions longer text",
                        systemImage: "pills.fill"
                    ) {
                        Text("Prescriptions View")
                    }
                    
                    GridNavigationButton(
                        title: "Appointments",
                        systemImage: "calendar.badge.clock"
                    ) {
                        Text("Appointments View")
                    }
                    
                    GridNavigationButton(
                        title: "Test results ",
                        systemImage: "waveform.path.ecg"
                    ) {
                        Text("Test Results View")
                    }
                    
                    GridNavigationButton(
                        title: "Vaccinations",
                        systemImage: "syringe"
                    ) {
                        Text("Vaccinations View")
                    }
                }
                .padding(.horizontal, 4)
            }
            .listRowInsets(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
            .listRowBackground(Color.clear)
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Preview")
        .background(Color(UIColor.systemGroupedBackground))
    }
}
