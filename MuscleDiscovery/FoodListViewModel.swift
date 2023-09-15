//
//  FoodListViewModel.swift
//  MuscleDiscovery
//
//  Created by Minh Trương on 15/09/2023.
//

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
