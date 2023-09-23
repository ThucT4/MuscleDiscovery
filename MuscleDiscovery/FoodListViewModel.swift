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
import FirebaseFirestore

class FoodListViewModel: ObservableObject {
    @Published var foodList = [Food]()
    
    private var db = Firestore.firestore().collection("foods")
    
    init() {
        getAllFoodData()
    }
    
    func getAllFoodData() {
        db.addSnapshotListener{ (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No food data on database.")
                return
            }

            self.foodList = documents.map{ (queryDocumentSnapshot) -> Food in
                let data = queryDocumentSnapshot.data()
                let id = data["id"] as? Int ?? 1
                let name = data["name"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let tags = data["tags"] as? [String] ?? [String]()
                let image = data["image"] as? String ?? ""
                let calo = data["calo"] as? CGFloat ?? 0.0
                let carbs = data["carbs"] as? CGFloat ?? 0.0
                let protein = data["protein"] as? CGFloat ?? 0.0
                let fat = data["fat"] as? CGFloat ?? 0.0
                
                return Food(id: id, name: name, description: description, tags: tags, image: image, calo: calo, carbs: carbs, protein: protein, fat: fat)
            }
        }
    }
    
}
