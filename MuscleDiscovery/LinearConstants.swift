//
//  LinearConstants.swift
//  MuscleDiscovery
//
//  Created by Thuc on 12/9/2023.
//

import Foundation
import SwiftUI

// This file contains all Color code for all elements includes main color and lightColor
struct LinearConstant {
    static let linearOrange = LinearGradient(colors: [Color(red: 0.95, green: 0.31, blue: 0.23), Color(red: 0.94, green: 0.49, blue: 0.23)]
                                             , startPoint: .topLeading, endPoint: .bottomTrailing)
    
    static let linearGreen = LinearGradient(colors: [ColorConstant.luminousGreen, ColorConstant.luminousGreen.opacity(0.5)]
                                           , startPoint: .bottomLeading, endPoint: .topTrailing)
}
