import Foundation

enum PrescriptionType: String, Codable {
    case repeatPrescription = "Repeat prescription"
    case oneOffPrescription = "One off prescription"
}

struct Prescription: Identifiable {
    let id = UUID()
    let name: String
    let details: String
    let date: String
    let status: String
    let type: PrescriptionType
}
