import SwiftUI

struct HealthConditionsView: View {

    let profile: Profile
    
    var body: some View {
        List {

            Section {
                RowLink(title: "Allergies and adverse reactions") { DetailView(index: 0) }
                RowLink(title: "All conditions") { DetailView(index: 0) }
            }
            .rowStyle(.white)

        }
        .navigationTitle("Health conditions")
        .navigationBarTitleDisplayMode(.large)
        .nhsListStyle()
    }
}

#Preview {
    HealthConditionsView(profile: Profile.profiles[0])
}
