import SwiftUI

// Identifiable wrapper for URLs
struct WebLink: Identifiable {
    let id = UUID()
    let url: URL
}

struct HomeViewV1: View {
    @State private var selectedLink: WebLink? = nil
    
    @State private var isNavigated = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            NavigationStack {
                List {
                    
                    Section {
                        NavigationLink("Prescriptions", destination: PrescriptionsViewV1())
                        NavigationLink("Appointments", destination: AppointmentsViewV1())
                        NavigationLink("Test results", destination: TestResultsViewV1())
                        NavigationLink("Vaccinations", destination: VaccinationsViewV1())
                        NavigationLink("Health conditions", destination: HealthConditionsViewV1())
                        NavigationLink("Documents", destination: DocumentsViewV1())
                    }
                    .rowStyle(.white)
                    
                    Section(header: Text("NHS information and support")) {
                        Button("Check your symptoms using 111 online") {
                            selectedLink = WebLink(url: URL(string: "https://111.nhs.uk/")!)
                        }
                        Button("Health A to Z") {
                            selectedLink = WebLink(url: URL(string: "https://www.nhs.uk")!)
                        }
                        Button("Find services near you") {
                            selectedLink = WebLink(url: URL(string: "https://www.nhs.uk")!)
                        }
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
                .background(Color.pageBackground)
                .sheet(item: $selectedLink) { link in
                    SafariView(url: link.url)
                }
                .environment(\.isNavigated, $isNavigated)
                .onAppear {
                    isNavigated = false
                }
            }
            
            // Logo - outside NavigationStack, only visible when not navigated
            if !isNavigated {
                Image("nhs_logo_blue")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 28)
                    .accessibilityLabel("NHS")
                    .padding(.leading, 16)
                    .padding(.top, 8)
                    .allowsHitTesting(false)
            }
        }
    }
}

#Preview {
    HomeViewV1()
}
