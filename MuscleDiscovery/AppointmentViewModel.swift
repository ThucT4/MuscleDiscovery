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

import SwiftUI
import FirebaseFirestore

class AppointmentViewModel: ObservableObject {
    @Published var userAppointments = [Appointment]()
    
    private var customerID: String = ""
    
    @Published var db = Firestore.firestore()
    
    init(customerID: String) {
        self.customerID = customerID
        self.userAppointments = [Appointment]()
        queryUserAppointments(customerID: customerID)
    }
    
    func queryUserAppointments(customerID: String) {
        
        self.userAppointments = [Appointment]()
        print("Before query: \(customerID)")
        let queryData = db.collection("appointments").whereField("customerID", isEqualTo: customerID)
        
        print(queryData)
        
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
                
                // If appointment is over
                if ( date + 30*60 <= Date.now) {
                    self.removeAppointment(documentID: documentID)
                    break
                }

                self.queryTrainerData(trainerID: trainerID) { (trainer) in
                    if let trainer = trainer {
                        self.userAppointments.append(Appointment(documentID: documentID, customerID: customerID, trainer: trainer, date: date))
                    }
                }
            }
            
            self.sortByDate()
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
    
    func bookAppointment(trainerID: String, date: Date) {
        db.collection("appointments").addDocument(data: ["customerID": self.customerID, "trainerID": trainerID, "date": date.timeIntervalSince1970])
    }
    
    func removeAppointment(documentID: String) {
        db.collection("appointments").document(documentID).delete { (err) in
            if let err = err {
                print("Error while removing document: \(err)")
            }
            else {
                print("Appointment successfully removed!")
            }
        }
    }
}
