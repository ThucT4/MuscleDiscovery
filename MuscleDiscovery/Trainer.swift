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
