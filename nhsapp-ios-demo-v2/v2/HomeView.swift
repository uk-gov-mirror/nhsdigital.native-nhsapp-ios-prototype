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

    @State private var activeCover: Cover? = nil
    @AccessibilityFocusState private var isSafariFocused: Bool

    @State private var toggleOne = true
    @State private var toggleTwo = false
    @State private var showPrescriptionCard = false
    @State private var isNavigated = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            NavigationStack {
                List {
                    // Prescription card (presenter lives OUTSIDE this conditional)
                    if showPrescriptionCard {
                        Section {
                            ZStack(alignment: .topTrailing) {
                                HStack(alignment: .top) {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Repeat prescription")
                                            .bold()
                                            .font(.footnote)
                                            .padding(.bottom, 4)
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
                                .accessibilityHint("Hides the ‘Prescription is ready to collect’ message.")
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
                        .rowStyle(.paleGreen)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            activeCover = .prescription
                        }
                        .transition(.move(edge: .top).combined(with: .opacity))
                    }
                    
                    // Navigation links (unchanged)
                    Section {
                        RowLink {
                            Label { Text("Prescriptions").foregroundColor(.text) } icon: {
                                Image(systemName: "pills.fill")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color("NHSBlue"))
                                    .padding(8)
                                    .background(Color("NHSGrey5"))
                                    .clipShape(Circle())
                            }
                        } destination: { PrescriptionsView() }
                        
                        RowLink {
                            Label { Text("Appointments").foregroundColor(.text) } icon: {
                                Image(systemName: "calendar.badge.clock")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color("NHSBlue"))
                                    .padding(8)
                                    .background(Color("NHSGrey5"))
                                    .clipShape(Circle())
                            }
                        } destination: { AppointmentsView() }
                        
                        RowLink {
                            Label { Text("Test results").foregroundColor(.text) } icon: {
                                Image(systemName: "waveform.path.ecg")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color("NHSBlue"))
                                    .padding(8)
                                    .background(Color("NHSGrey5"))
                                    .clipShape(Circle())
                            }
                        } destination: { TestResultsView() }
                        
                        RowLink {
                            Label { Text("Vaccinations").foregroundColor(.text) } icon: {
                                Image(systemName: "syringe")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color("NHSBlue"))
                                    .padding(8)
                                    .background(Color("NHSGrey5"))
                                    .clipShape(Circle())
                            }
                        } destination: { VaccinationsView() }
                        
                        RowLink {
                            Label { Text("Health conditions").foregroundColor(.text) } icon: {
                                Image(systemName: "cross.case.fill")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color("NHSBlue"))
                                    .padding(8)
                                    .background(Color("NHSGrey5"))
                                    .clipShape(Circle())
                            }
                        } destination: { HealthConditionsView() }
                        
                        RowLink {
                            Label { Text("Documents").foregroundColor(.text) } icon: {
                                Image(systemName: "doc.text.fill")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color("NHSBlue"))
                                    .padding(8)
                                    .background(Color("NHSGrey5"))
                                    .clipShape(Circle())
                            }
                        } destination: { DocumentsView() }
                    }
                    .rowStyle(.white)
                    
                    // External links -> drive via the same enum
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
            .environment(\.isNavigated, $isNavigated)
            .onAppear {
                isNavigated = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showPrescriptionCard = true
                    }
                }
            }
            
            // Logo - outside NavigationStack, only visible when not navigated
            if !isNavigated {
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
