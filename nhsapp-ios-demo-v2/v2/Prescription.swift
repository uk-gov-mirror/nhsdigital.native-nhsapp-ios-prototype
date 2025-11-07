import Foundation

struct Prescription: Identifiable {
    let id = UUID()
    let name: String
    let details: String
    let date: String
    let status: String
}
