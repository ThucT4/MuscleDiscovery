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

class TrainerViewModel: ObservableObject {
    @Published var trainerList = [Trainer]()
    
    private var db = Firestore.firestore().collection("trainers")
    
    init() {
        getAllTrainerData(searchName: "")
    }
    
    func getAllTrainerData(searchName: String) {
        db.addSnapshotListener{ (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No trainer data on database.")
                return
            }

            self.trainerList = documents.map{ (queryDocumentSnapshot) -> Trainer in
                let data = queryDocumentSnapshot.data()
                let age = data["age"] as? Int ?? 1
                let documentID = queryDocumentSnapshot.documentID
                let experience = data["experience"] as? Int ?? 0
                let gender = data["gender"] as? String ?? ""
                let highlights = data["highlights"] as? [String] ?? [String]()
                let imageURL = data["image"] as? String ?? ""
                let introduction = data["introduction"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                var rating = data["rating"] as? Double ?? 1

                rating = Double(round(10*rating) / 10)

                return Trainer(documentID: documentID, age: age, experience: experience, gender: gender, highlights: highlights, imageURL: imageURL, introduction: introduction, name: name, rating: rating)
            }
            
            if (!searchName.isEmpty) {
                self.trainerList = self.trainerList.filter {trainer in
                                    trainer.name!.lowercased().contains(searchName.lowercased())
                                }
            }
            
            self.sortByRating(desc: false)
        }
    }
    
    func sortByRating(desc: Bool) {
        self.trainerList = self.trainerList.sorted{$0.rating! < $1.rating!}
        
        if (!desc) {
            self.trainerList = self.trainerList.reversed()
        }
    }
    
    func sortByExperience(desc: Bool) {
        self.trainerList = self.trainerList.sorted{$0.experience! < $1.experience!}
        
        if (!desc) {
            self.trainerList = self.trainerList.reversed()
        }
    }
    
}
