//
//  Appointment.swift
//  MuscleDiscovery
//
//  Created by Thuc on 13/9/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct Appointment: Codable, Identifiable {
    var id: String = UUID().uuidString
    @DocumentID var documentID: String?
    var customerID: String?
    var trainer: Trainer?
    var date: Date?
}
