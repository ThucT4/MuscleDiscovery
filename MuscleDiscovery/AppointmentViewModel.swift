//
//  PaymentViewModel.swift
//  MuscleDiscovery
//
//  Created by Thuc on 13/9/2023.
//

import SwiftUI
import FirebaseFirestore

class AppointmentViewModel: ObservableObject {
    @Published var userAppointments = [Appointment]()
    
    private var db = Firestore.firestore()
    
    init(customerID: String) {
        self.userAppointments = [Appointment]()
        queryUserAppointments(customerID: customerID)
    }
    
    func queryUserAppointments(customerID: String) {
        let queryData = db.collection("appointments").whereField("customerID", isEqualTo: customerID)
        
        queryData.addSnapshotListener{ (querySnapshot, error) in
            self.userAppointments = [Appointment]()
            
            guard let documents = querySnapshot?.documents else {
                print("No appointment data on database.")
                return
            }
            
            for document in documents {
                let data = document.data()
                let documentID = document.documentID
                let customerID = data["customerID"] as? String ?? ""
                let trainerID = data["trainerID"] as? String ?? ""
                let timeStamp = data["date"] as? Double ?? 0.0
                let date = Date(timeIntervalSince1970: timeStamp)

                self.queryTrainerData(trainerID: trainerID) { (trainer) in
                    if let trainer = trainer {
                        self.userAppointments.append(Appointment(documentID: documentID, customerID: customerID, trainer: trainer, date: date))
                    }
                }
            }
        }
    }
    
    func sortByDate() {
        self.userAppointments = self.userAppointments.sorted{$0.date!.timeIntervalSince1970 < $1.date!.timeIntervalSince1970}
    }
    
    func queryTrainerData(trainerID: String, completion: @escaping (Trainer?) -> Void) {
        
        return self.db.collection("trainers").document(trainerID).getDocument { (document, error) -> Void in
            if let error = error as NSError? {
                print("\(error.localizedDescription)")
            }
            else {
                if let document = document {
                    let data = document.data()!
                    let age = data["age"] as? Int ?? 1
                    let documentID = document.documentID
                    let experience = data["experience"] as? Int ?? 0
                    let gender = data["gender"] as? String ?? ""
                    let highlights = data["highlights"] as? [String] ?? [String]()
                    let imageURL = data["image"] as? String ?? ""
                    let introduction = data["introduction"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    var rating = data["rating"] as? Double ?? 1
                    
                    rating = Double(round(10*rating) / 10)

                    let trainer = Trainer(documentID: documentID, age: age, experience: experience, gender: gender, highlights: highlights, imageURL: imageURL, introduction: introduction, name: name, rating: rating)

                    completion(trainer)
                }
            }
        }
    }
    
    func bookAppointment(customerID: String, trainerID: String, date: Date) {
        db.collection("appointments").addDocument(data: ["customerID": customerID, "trainerID": trainerID, "date": date.timeIntervalSince1970])
    }
    
}
