/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2023B
    Assessment: Assignment 3
    Author: Lai Nghiep Tri, Thieu Tran Tri Thuc, Truong Bach Minh, Vo Thanh Thong
    ID: s3799602, s3870730, s3891909, s3878071
    Created  date: 12/9/2023
    Last modified: 25/9/2023
    Acknowledgement:
        - The UI designs are inspired from:
            “Gym fitness app ui kit: Figma community,” Figma, https://www.figma.com/community/file/1096744662320428503 (accessed Sep. 12, 2023).
 */

import Foundation
import SwiftUI

// This file contains all Color code for all elements includes main color and lightColor
struct LinearConstant {
    static let linearOrange = LinearGradient(colors: [Color(red: 0.95, green: 0.31, blue: 0.23), Color(red: 0.94, green: 0.49, blue: 0.23)]
                                             , startPoint: .topLeading, endPoint: .bottomTrailing)
    
    static let linearGreen = LinearGradient(colors: [Color("Neon"), Color("Neon").opacity(0.5)]
                                           , startPoint: .bottomLeading, endPoint: .topTrailing)
}
