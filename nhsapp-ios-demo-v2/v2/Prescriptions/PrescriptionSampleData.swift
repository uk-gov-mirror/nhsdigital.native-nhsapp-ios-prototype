import Foundation

extension Prescription {
    
    static let activeSampleData: [Prescription] = [
        Prescription(
            medicines: [
                Medicine(name: "Ramipril", dosage: "5mg tablets")
            ],
            date: "18 Oct 2025",
            status: "Ready to collect",
            type: .repeatPrescription
        ),
        
        Prescription(
            medicines: [
                Medicine(name: "Amoxicillin", dosage: "500mg capsules"),
                Medicine(name: "Amlodipine", dosage: "10mg tablets"),
                Medicine(name: "Atorvastatin", dosage: "20mg tablets")
            ],
            date: "12 Oct 2025",
            status: "Pending",
            type: .oneOffPrescription
        ),
        
        Prescription(
            medicines: [
                Medicine(name: "Levothyroxine", dosage: "50 microgram tablets")
            ],
            date: "10 Oct 2025",
            status: "Pending",
            type: .repeatPrescription
        ),

        Prescription(
            medicines: [
                Medicine(name: "Atorvastatin", dosage: "20mg tablets"),
                Medicine(name: "Amlodipine", dosage: "10mg tablets")
            ],
            date: "08 Oct 2025",
            status: "Awaiting GP approval",
            type: .repeatPrescription
        )
    ]
    
    static let pastSampleData: [Prescription] = [
        Prescription(
            medicines: [
                Medicine(name: "Omeprazole", dosage: "20mg capsules")
            ],
            date: "15 Sep 2025",
            status: "Collected on 20 Sep 2025",
            type: .repeatPrescription
        ),

        Prescription(
            medicines: [
                Medicine(name: "Prednisolone", dosage: "5mg tablets")
            ],
            date: "01 Aug 2025",
            status: "Collected on 05 Aug 2025",
            type: .oneOffPrescription
        ),

        Prescription(
            medicines: [
                Medicine(name: "Salbutamol Inhaler", dosage: "100 micrograms")
            ],
            date: "10 Jul 2025",
            status: "Collected on 12 Jul 2025",
            type: .repeatPrescription
        ),

        Prescription(
            medicines: [
                Medicine(name: "Co-codamol", dosage: "8/500mg tablets")
            ],
            date: "25 Jun 2025",
            status: "Collected on 27 Jun 2025",
            type: .oneOffPrescription
        ),

        Prescription(
            medicines: [
                Medicine(name: "Metformin", dosage: "500mg tablets"),
                Medicine(name: "Gliclazide", dosage: "80mg tablets")
            ],
            date: "12 Jun 2025",
            status: "Collected on 14 Jun 2025",
            type: .repeatPrescription
        ),

        Prescription(
            medicines: [
                Medicine(name: "Flucloxacillin", dosage: "500mg capsules")
            ],
            date: "01 May 2025",
            status: "Collected on 02 May 2025",
            type: .oneOffPrescription
        ),

        Prescription(
            medicines: [
                Medicine(name: "Cetirizine", dosage: "10mg tablets")
            ],
            date: "15 Apr 2025",
            status: "Collected on 16 Apr 2025",
            type: .oneOffPrescription
        ),

        Prescription(
            medicines: [
                Medicine(name: "Sertraline", dosage: "50mg tablets"),
                Medicine(name: "Propranolol", dosage: "10mg tablets")
            ],
            date: "20 Mar 2025",
            status: "Collected on 22 Mar 2025",
            type: .repeatPrescription
        ),

        Prescription(
            medicines: [
                Medicine(name: "Loratadine", dosage: "10mg tablets")
            ],
            date: "02 Mar 2025",
            status: "Collected on 03 Mar 2025",
            type: .oneOffPrescription
        ),

        Prescription(
            medicines: [
                Medicine(name: "Bisoprolol", dosage: "5mg tablets"),
                Medicine(name: "Lisinopril", dosage: "10mg tablets")
            ],
            date: "10 Feb 2025",
            status: "Collected on 12 Feb 2025",
            type: .repeatPrescription
        )
    ]
}
