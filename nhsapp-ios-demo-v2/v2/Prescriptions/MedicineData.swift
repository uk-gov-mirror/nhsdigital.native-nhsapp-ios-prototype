import Foundation

struct Medicine: Identifiable, Codable {
    let id: UUID
    let name: String
    let dosage: String

    init(id: UUID = UUID(), name: String, dosage: String) {
        self.id = id
        self.name = name
        self.dosage = dosage
    }
}
