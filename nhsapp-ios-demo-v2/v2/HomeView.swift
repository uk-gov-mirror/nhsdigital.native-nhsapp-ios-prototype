import SwiftUI

struct HomeView: View {

    // Use an Identifiable item so the cover only shows when non-nil
    struct LinkItem: Identifiable, Equatable {
        let id = UUID()
        let title: String
        let url: URL
    }

    @State private var selectedLink: LinkItem? = nil
    
    @AccessibilityFocusState private var isSafariFocused: Bool

    // State variables for toggle examples
    @State private var toggleOne = true
    @State private var toggleTwo = false
    
    // Start hidden so we can animate it in after a delay
    @State private var showPrescriptionCard = false
    
    @State private var showPrescription = false

    var body: some View {
        NavigationStack {
            List {
                
                // Prescription card (no persistence; shows after delay on each appearance)
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
                                    .accessibilityLabel("Dismiss prescription")
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
                    .contentShape(Rectangle()) // Makes entire area tappable
                    .onTapGesture {
                        showPrescription = true
                    }
                    .fullScreenCover(isPresented: $showPrescription) {
                        PrescriptionDetailView()
                    }
                    .transition(.move(edge: .top).combined(with: .opacity))
                }
                
                // Navigation links
                Section {
                    RowLink {
                        Label {
                            Text("Prescriptions")
                                .foregroundColor(.text)
                        } icon: {
                            Image(systemName: "pills.fill")
                                .font(.system(size: 12))
                                .foregroundColor(Color("NHSBlue"))
                                .padding(8)
                                .background(Color("NHSGrey5"))
                                .clipShape(Circle())
                        }
                    } destination: { PrescriptionsView() }

                    RowLink {
                        Label {
                            Text("Appointments")
                                .foregroundColor(.text)
                        } icon: {
                            Image(systemName: "calendar.badge.clock")
                                .font(.system(size: 12))
                                .foregroundColor(Color("NHSBlue"))
                                .padding(8)
                                .background(Color("NHSGrey5"))
                                .clipShape(Circle())
                        }
                    } destination: { AppointmentsView() }

                    RowLink {
                        Label {
                            Text("Test results")
                                .foregroundColor(.text)
                        } icon: {
                            Image(systemName: "waveform.path.ecg")
                                .font(.system(size: 12))
                                .foregroundColor(Color("NHSBlue"))
                                .padding(8)
                                .background(Color("NHSGrey5"))
                                .clipShape(Circle())
                        }
                    } destination: { TestResultsView() }

                    RowLink {
                        Label {
                            Text("Vaccinations")
                                .foregroundColor(.text)
                        } icon: {
                            Image(systemName: "syringe")
                                .font(.system(size: 12))
                                .foregroundColor(Color("NHSBlue"))
                                .padding(8)
                                .background(Color("NHSGrey5"))
                                .clipShape(Circle())
                        }
                    } destination: { VaccinationsView() }

                    RowLink {
                        Label {
                            Text("Health conditions")
                                .foregroundColor(.text)
                        } icon: {
                            Image(systemName: "cross.case.fill")
                                .font(.system(size: 12))
                                .foregroundColor(Color("NHSBlue"))
                                .padding(8)
                                .background(Color("NHSGrey5"))
                                .clipShape(Circle())
                        }
                    } destination: { HealthConditionsView() }

                    RowLink {
                        Label {
                            Text("Documents")
                                .foregroundColor(.text)
                        } icon: {
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


                // External link rows (multiple)
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
                
                // Campaign card
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
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.large)
        }
        .background(Color.pageBackground)
        .onAppear {
            // Re-schedule every time HomeView appears
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showPrescriptionCard = true
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
