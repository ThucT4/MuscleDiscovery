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

struct TrainerRow: View {
    var trainer: Trainer
    
    private var imageURL: URL {
        return URL(string: trainer.imageURL ?? "")!
    }
    
    var body: some View {
        // MARK: Main HStack
        HStack {
            // MARK: Circle to take space while waiting for image loading
            Circle()
                .fill(Color("Dark grey"))
                .frame(width: 80)
                .overlay(alignment: .center, content: {
                    AsyncImage(url: imageURL) {image in
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 80)
                    } placeholder: {
                        ProgressView()
                            .tint(Color("Neon"))
                    }
                })
                .padding()
            
            // MARK: Trainer infomation
            VStack (spacing: 10) {
                Text(trainer.name!)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Rectangle()
                    .fill(Color("Neon"))
                    .cornerRadius(5)
                    .frame(width: 40, height: 25)
                    .overlay(alignment: .center, content: {
                        Text("\(trainer.rating!.clean)")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    })
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(trainer.experience!) year\( trainer.experience! > 1 ? "s" : "") experience")
                    .font(.body)
                    .foregroundColor(Color("Neon"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            } // end Trainer infomation
            
            Spacer()
            
        } // end Main HStack
        .background(Color("Dark grey"))
        .clipShape(RoundedRectangle(cornerRadius: 20))  // Rounded corner
    }
}
