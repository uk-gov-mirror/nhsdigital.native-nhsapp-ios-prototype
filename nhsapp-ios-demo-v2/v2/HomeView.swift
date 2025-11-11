import SwiftUI

// Profile model
struct Profile: Identifiable, Equatable {
    let id: Int
    let name: String
    let nhsNumber: String
    let color: Color
    
    static let profiles = [
        Profile(id: 0, name: "David Hunter", nhsNumber: "123 456 789", color: Color("NHSAppBlue")),
        Profile(id: 1, name: "Sarah Hunter", nhsNumber: "987 654 321", color: Color("NHSPurple")),
        Profile(id: 2, name: "Emma Hunter", nhsNumber: "456 789 123", color: Color("NHSPink"))
    ]
}

struct HomeView: View {
    
    // MARK: - State Variables
    @State private var chosenProfile: Profile = Profile.profiles[0]
    @State private var selectedLink: LinkItem? = nil
    @AccessibilityFocusState private var isSafariFocused: Bool
    @State private var showPrescriptionCard = false
    @State private var showAppointmentCard = true
    
    // MARK: - Link Item
    struct LinkItem: Identifiable, Equatable {
        let id = UUID()
        let title: String
        let url: URL
    }

    var body: some View {
        NavigationStack {
            List {
                
                // MARK: - Profile Card Selector
                Section {
                    GeometryReader { geometry in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(Profile.profiles) { profile in
                                    ProfileCard(
                                        profile: profile,
                                        isSelected: chosenProfile.id == profile.id
                                    )
                                    .onTapGesture {
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                            chosenProfile = profile
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                            .scrollTargetLayout()
                        }
                        .scrollTargetBehavior(.viewAligned)
                        .scrollPosition(id: .constant(chosenProfile.id))
                        .contentMargins(.horizontal, 0)
                    }
                    .frame(height: 180)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                }
                .listRowBackground(Color.clear)
                
                
                
                // MARK: - Navigation Links
                Section {
                    RowLink {
                        Label {
                            Text("Prescriptions")
                                .foregroundColor(.text)
                        } icon: {
                            Image(systemName: "pills.fill")
                                .font(.system(size: 12))
                                .foregroundColor(Color("NHSPurple"))
                                .padding(8)
                                .background(Color("NHSAppPalePurple"))
                                .clipShape(Circle())
                        }
                    } destination: { PrescriptionsView(profile: chosenProfile) }

                    RowLink {
                        Label {
                            Text("Appointments")
                                .foregroundColor(.text)
                        } icon: {
                            Image(systemName: "calendar.badge.clock")
                                .font(.system(size: 12))
                                .foregroundColor(.accentColor)
                                .padding(8)
                                .background(Color("NHSAppPaleBlue"))
                                .clipShape(Circle())
                        }
                    } destination: { AppointmentsView(profile: chosenProfile) }

                    RowLink {
                        Label {
                            Text("Test results")
                                .foregroundColor(.text)
                        } icon: {
                            Image(systemName: "waveform.path.ecg")
                                .font(.system(size: 12))
                                .foregroundColor(Color("NHSPink"))
                                .padding(8)
                                .background(Color("NHSAppPalePink"))
                                .clipShape(Circle())
                        }
                    } destination: { TestResultsView(profile: chosenProfile) }

                    RowLink {
                        Label {
                            Text("Vaccinations")
                                .foregroundColor(.text)
                        } icon: {
                            Image(systemName: "syringe")
                                .font(.system(size: 12))
                                .foregroundColor(Color("NHSOrange"))
                                .padding(8)
                                .background(Color("NHSAppPaleOrange"))
                                .clipShape(Circle())
                        }
                    } destination: { VaccinationsView(profile: chosenProfile) }

                    RowLink {
                        Label {
                            Text("Health conditions")
                                .foregroundColor(.text)
                        } icon: {
                            Image(systemName: "cross.case.fill")
                                .font(.system(size: 12))
                                .foregroundColor(Color("NHSAquaGreen"))
                                .padding(8)
                                .background(Color("NHSAppPaleAquaGreen"))
                                .clipShape(Circle())
                        }
                    } destination: { HealthConditionsView(profile: chosenProfile) }

                    RowLink {
                        Label {
                            Text("Documents")
                                .foregroundColor(.text)
                        } icon: {
                            Image(systemName: "doc.text.fill")
                                .font(.system(size: 12))
                                .foregroundColor(Color("NHSRed"))
                                .padding(8)
                                .background(Color("NHSAppPaleRed"))
                                .clipShape(Circle())
                        }
                    } destination: { DocumentsView(profile: chosenProfile) }
                }
                .rowStyle(.white)

                // MARK: - External Links
                Section {
                    ExternalLinkRow(title: "Check your symptoms using 111 online",
                                    url: URL(string: "https://111.nhs.uk/")!) { url in
                        selectedLink = LinkItem(title: "Check your symptoms using 111 online", url: url)
                    }
                    ExternalLinkRow(title: "Health A to Z",
                                    url: URL(string: "https://www.nhs.uk")!) { url in
                        selectedLink = LinkItem(title: "Health A to Z", url: url)
                    }
                    ExternalLinkRow(title: "Find services near you",
                                    url: URL(string: "https://www.nhs.uk")!) { url in
                        selectedLink = LinkItem(title: "Find services near you", url: url)
                    }
                } header: {
                    Text("NHS information and support")
                }
                .rowStyle(.white)
                
                // MARK: - Campaign Card
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
            .fullScreenCover(item: $selectedLink) { link in
                SafariView(url: link.url)
                    .ignoresSafeArea()
                    .accessibilityFocused($isSafariFocused)
                    .onAppear { isSafariFocused = true }
            }
            .nhsListStyle()
        }
        .background(Color.pageBackground)
    }
}

// MARK: - Profile Card View
struct ProfileCard: View {
    let profile: Profile
    let isSelected: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Image("nhs_logo")
                .resizable()
                .scaledToFit()
                .frame(height: 28)
                .accessibilityLabel("NHS")
                .padding(.bottom, 12)
            
            Text(profile.name)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
            
            Text("\(Text("NHS number: ").bold())\(profile.nhsNumber)")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.9))
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 80, height: 140)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(profile.color)
        )
        .shadow(color: isSelected ? .black.opacity(0.2) : .clear, radius: 8, x: 0, y: 4)
        .scaleEffect(isSelected ? 1.0 : 0.95)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
    }
}



#Preview {
    HomeView()
}
