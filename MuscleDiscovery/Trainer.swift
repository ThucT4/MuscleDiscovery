//
//  Trainer.swift
//  MuscleDiscovery
//
//  Created by Thuc on 12/9/2023.
//

import Foundation

struct Trainer: Codable, Identifiable {
    var id: String = UUID().uuidString
    var documentID: String?
    var age: Int?
    var experience: Int?
    var gender: String?
    var highlights: [String]?
    var imageURL: String?
    var introduction: String?
    var name: String?
    var rating: Double?
}
