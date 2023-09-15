//
//  Food.swift
//  MuscleDiscovery
//
//  Created by Minh Trương on 15/09/2023.
//

import Foundation

import Foundation

import SwiftUI
import CoreLocation

struct Food: Identifiable, Codable, Equatable{
    var id: Int?
    var name: String?
    var description: String?
    var tags: [String]?
    var imageURL: String?
    var calo: CGFloat?
    var carbs: CGFloat?
    var protein: CGFloat?
    var fat: CGFloat?
        
}
