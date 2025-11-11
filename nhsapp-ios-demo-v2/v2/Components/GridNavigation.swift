import SwiftUI

struct GridNavigationButton<Destination: View>: View {
    let title: String
    let systemImage: String
    @ViewBuilder let destination: () -> Destination
    @State private var navigate = false
    @Environment(\.isNavigated) private var isNavigated
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    // Use @ScaledMetric to scale values with Dynamic Type
    @ScaledMetric(relativeTo: .body) private var iconSize: CGFloat = 24
    @ScaledMetric(relativeTo: .body) private var padding: CGFloat = 16
    @ScaledMetric(relativeTo: .body) private var iconBottomPadding: CGFloat = 0
    
    var body: some View {
        Button(action: {
            navigate = true
            isNavigated.wrappedValue = true
        }) {
            VStack(alignment: .leading, spacing: iconBottomPadding) {
                
                HStack(alignment: .center) {
                    
                    Image(systemName: systemImage)
                        .font(.system(size: iconSize))
                        .foregroundColor(Color("AccentColor"))
                        .accessibilityHidden(true)
                        .frame(width: iconSize, height: iconSize)
                        .padding(.horizontal, 8)
                    
                    Text(title)
                        .font(.body)
                        .foregroundColor(.text)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(nil)
                    
                    Spacer(minLength: 8)
                    
                    Image(systemName: "chevron.right")
                        .font(.subheadline)
                        .foregroundColor(Color("NHSGrey2"))
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

struct AdaptiveGridView: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    // Determine if we should use single column based on text size
    private var useSingleColumn: Bool {
        // Switch to single column for accessibility sizes and larger regular sizes
        dynamicTypeSize.isAccessibilitySize || dynamicTypeSize >= .xxLarge
    }
    
    // Define grid columns based on text size
    private var gridColumns: [GridItem] {
        if useSingleColumn {
            // Single column for larger text sizes
            return [GridItem(.flexible(), spacing: 8)]
        } else {
            // Two columns for normal text sizes
            return [
                GridItem(.flexible(), spacing: 8)
                ]
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    LazyVGrid(columns: gridColumns, spacing: 12) {
                        GridNavigationButton(
                            title: "Prescriptions",
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
                            title: "Test results",
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
                    .padding(.top, 8)
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
            .nhsListStyle()
            .navigationTitle("Home")
        }
    }
}

#Preview("Adaptive Grid") {
    AdaptiveGridView()
}

