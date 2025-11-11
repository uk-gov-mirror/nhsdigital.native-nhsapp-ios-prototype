import SwiftUI

struct HomeView: View {

    struct LinkItem: Identifiable, Equatable {
        let id = UUID()
        let title: String
        let url: URL
    }

    enum Cover: Identifiable, Equatable {
        case safari(LinkItem)
        case prescription
        var id: String {
            switch self {
            case .safari(let item): return "safari-\(item.id)"
            case .prescription:     return "prescription"
            }
        }
    }
    
    // Define navigation destinations as an enum
    enum NavigationDestination: Hashable {
        case prescriptions
        case appointments
        case testResults
        case vaccinations
        case healthConditions
        case documents
    }

    @State private var activeCover: Cover? = nil
    @AccessibilityFocusState private var isSafariFocused: Bool

    @State private var toggleOne = true
    @State private var toggleTwo = false
    @State private var showPrescriptionCard = false
    @State private var navigationPath = NavigationPath()
    
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
        
    // Determine grid layout based on text size
    private var gridColumns: [GridItem] {
        if dynamicTypeSize.isAccessibilitySize || dynamicTypeSize >= .xxxLarge {
            // Single column for larger text
            return [GridItem(.flexible(), spacing: 12)]
        } else {
            // Two columns for normal text
            return [
                GridItem(.flexible(), spacing: 12),
                GridItem(.flexible(), spacing: 12)
            ]
        }
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            NavigationStack(path: $navigationPath) {
                List {

                    if showPrescriptionCard {
                        Section {
                            ZStack(alignment: .topTrailing) {
                                HStack(alignment: .top) {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Repeat prescription")
                                            .bold()
                                            .font(.footnote)
                                            .padding(.bottom, 4)
                                            .foregroundStyle(Color("NHSBlack"))
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
                                }
                                
                                Button {
                                    withAnimation(.easeInOut) {
                                        showPrescriptionCard = false
                                    }
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.title2)
                                        .foregroundColor(Color("NHSAppDarkGreen"))
                                }
                                .accessibilityLabel("Dismiss prescription")
                                .accessibilityHint("Hides the 'Prescription is ready to collect' message.")
                            }
                            
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
                        .rowStyle(.prescriptionGreen)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            activeCover = .prescription
                        }
                        .transition(.move(edge: .top).combined(with: .opacity))
                    }
                    
                    Section {
                        LazyVGrid(columns: gridColumns, spacing: 12) {
                            SimpleGridNavigationButton(
                                title: "Prescriptions",
                                systemImage: "pills.fill",
                                action: { navigationPath.append(NavigationDestination.prescriptions) }
                            )
                            SimpleGridNavigationButton(
                                title: "Appointments",
                                systemImage: "calendar.badge.clock",
                                action: { navigationPath.append(NavigationDestination.appointments) }
                            )
                            SimpleGridNavigationButton(
                                title: "Test results",
                                systemImage: "waveform.path.ecg",
                                action: { navigationPath.append(NavigationDestination.testResults) }
                            )
                            SimpleGridNavigationButton(
                                title: "Vaccinations",
                                systemImage: "syringe",
                                action: { navigationPath.append(NavigationDestination.vaccinations) }
                            )
                            SimpleGridNavigationButton(
                                title: "Health conditions",
                                systemImage: "cross.case.fill",
                                action: { navigationPath.append(NavigationDestination.healthConditions) }
                            )
                            SimpleGridNavigationButton(
                                title: "Documents",
                                systemImage: "doc.text.fill",
                                action: { navigationPath.append(NavigationDestination.documents) }
                            )
                        }
                        .padding(.horizontal, 0)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .environment(\.defaultMinListRowHeight, 0)
                    
                    
                    // External links
                    Section {
                        ExternalLinkRow(title: "Check your symptoms using 111 online",
                                        url: URL(string: "https://111.nhs.uk/")!) { url in
                            activeCover = .safari(.init(title: "Check your symptoms using 111 online", url: url))
                        }
                        ExternalLinkRow(title: "Health A to Z",
                                        url: URL(string: "https://www.nhs.uk")!) { url in
                            activeCover = .safari(.init(title: "Health A to Z", url: url))
                        }
                        ExternalLinkRow(title: "Find services near you",
                                        url: URL(string: "https://www.nhs.uk")!) { url in
                            activeCover = .safari(.init(title: "Find services near you", url: url))
                        }
                    } header: {
                        Text("NHS information and support")
                    }
                    .rowStyle(.white)
                    
                    Section {
                        CampaignCard(
                            imageName: "campaign_img",
                            title: "Organ donors save lives",
                            subtitle: "Take two minutes to confirm your organ donation decision",
                            backgroundColor: Color("NHSAppDarkBlue"),
                            chevronColor: Color("NHSAppPaleBlue")
                        ) {
                            DetailView(index: 0)
                        }
                    }
                    .campaignCardRowStyle()
                }
                .nhsListStyle()
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.large)
                .appHelpToolbar()
                // Define all navigation destinations here
                .navigationDestination(for: NavigationDestination.self) { destination in
                    switch destination {
                    case .prescriptions:
                        PrescriptionsView()
                    case .appointments:
                        AppointmentsView()
                    case .testResults:
                        TestResultsView()
                    case .vaccinations:
                        VaccinationsView()
                    case .healthConditions:
                        HealthConditionsView()
                    case .documents:
                        DocumentsView()
                    }
                }
            }
            .background(Color.pageBackground)
            .fullScreenCover(item: $activeCover) { cover in
                switch cover {
                case .prescription:
                    PrescriptionDetailView()
                case .safari(let link):
                    SafariView(url: link.url)
                        .ignoresSafeArea()
                        .accessibilityFocused($isSafariFocused)
                        .onAppear { isSafariFocused = true }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showPrescriptionCard = true
                    }
                }
            }
            
            // Logo - outside NavigationStack, only visible when at root of navigation
            if navigationPath.isEmpty {
                Image("nhs_logo_blue")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 32)
                    .accessibilityLabel("NHS")
                    .padding(.leading, 16)
                    .padding(.top, 8)
                    .allowsHitTesting(false)
            }
        }
    }
}

#Preview {
    HomeView()
}
