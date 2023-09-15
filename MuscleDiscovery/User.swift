//
//  User.swift
//  MuscleDiscovery
//
//  Created by Thuc on 13/9/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable {
//    var id: String = UUID().uuidString
    @DocumentID var documentID: String?
    var name: String
    var appointments: [Appointment]
}
