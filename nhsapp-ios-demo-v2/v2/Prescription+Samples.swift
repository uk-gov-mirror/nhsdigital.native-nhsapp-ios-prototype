import Foundation

extension Prescription {
    
    static let activeSampleData: [Prescription] = [
        Prescription(
            name: "Ramipril",
            details: "5mg tablets",
            date: "18 Oct 2025",
            status: "Ready to collect",
            type: .repeatPrescription
        ),
        Prescription(
            name: "Amoxicillin",
            details: "500mg capsules",
            date: "12 Oct 2025",
            status: "Pending",
            type: .oneOffPrescription
        )
    ]
    
    static let pastSampleData: [Prescription] = [
        Prescription(
            name: "Omeprazole",
            details: "20mg capsules",
            date: "15 Sep 2025",
            status: "Collected on 20 Sep 2025",
            type: .repeatPrescription
        ),
        Prescription(
            name: "Prednisolone",
            details: "5mg tablets",
            date: "01 Aug 2025",
            status: "Collected on 05 Aug 2025",
            type: .oneOffPrescription
        )
    ]
}
