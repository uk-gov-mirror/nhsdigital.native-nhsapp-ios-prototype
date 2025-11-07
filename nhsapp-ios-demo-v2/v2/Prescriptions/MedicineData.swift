struct Medicine: Identifiable, Codable {
    let id = UUID()
    let name: String          // e.g. "Paracetamol"
    let dosage: String        // e.g. "500mg tablets"
}
