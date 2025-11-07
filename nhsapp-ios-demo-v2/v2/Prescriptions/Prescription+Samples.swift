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
        ),
        
        Prescription(
            name: "Levothyroxine",
            details: "50 microgram tablets",
            date: "10 Oct 2025",
            status: "Pending",
            type: .repeatPrescription
        ),

        Prescription(
            name: "Atorvastatin",
            details: "20mg tablets",
            date: "08 Oct 2025",
            status: "Awaiting GP approval",
            type: .repeatPrescription
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
        ),

        Prescription(
            name: "Salbutamol Inhaler",
            details: "100 micrograms",
            date: "10 Jul 2025",
            status: "Collected on 12 Jul 2025",
            type: .repeatPrescription
        ),

        Prescription(
            name: "Co-codamol",
            details: "8/500mg tablets",
            date: "25 Jun 2025",
            status: "Collected on 27 Jun 2025",
            type: .oneOffPrescription
        ),

        Prescription(
            name: "Metformin",
            details: "500mg tablets",
            date: "12 Jun 2025",
            status: "Collected on 14 Jun 2025",
            type: .repeatPrescription
        ),

        Prescription(
            name: "Flucloxacillin",
            details: "500mg capsules",
            date: "01 May 2025",
            status: "Collected on 02 May 2025",
            type: .oneOffPrescription
        ),

        Prescription(
            name: "Cetirizine",
            details: "10mg tablets",
            date: "15 Apr 2025",
            status: "Collected on 16 Apr 2025",
            type: .oneOffPrescription
        ),

        Prescription(
            name: "Sertraline",
            details: "50mg tablets",
            date: "20 Mar 2025",
            status: "Collected on 22 Mar 2025",
            type: .repeatPrescription
        ),

        Prescription(
            name: "Loratadine",
            details: "10mg tablets",
            date: "02 Mar 2025",
            status: "Collected on 03 Mar 2025",
            type: .oneOffPrescription
        ),

        Prescription(
            name: "Bisoprolol",
            details: "5mg tablets",
            date: "10 Feb 2025",
            status: "Collected on 12 Feb 2025",
            type: .repeatPrescription
        )
    ]

}
