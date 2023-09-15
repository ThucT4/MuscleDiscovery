//
//  TrainerRow.swift
//  MuscleDiscovery
//
//  Created by Thuc on 12/9/2023.
//

import SwiftUI

struct TrainerRow: View {
    var trainer: Trainer
    
    private var imageURL: URL {
        return URL(string: trainer.imageURL ?? "")!
    }
    
    var body: some View {
        // MARK: Main HStack
        HStack {
            // Circle to take space while waiting for image loading
            Circle()
                .fill(ColorConstant.gray)
                .frame(width: 80)
                .overlay(alignment: .center, content: {
                    AsyncImage(url: imageURL) {image in
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 80)
                    } placeholder: {
                        
                    }
                })
                .padding()
            
            VStack (spacing: 10) {
                Text(trainer.name!)
                    .font(.system(size: 20, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Rectangle()
                    .fill(ColorConstant.luminousGreen)
                    .cornerRadius(5)
                    .frame(width: 40, height: 25)
                    .overlay(alignment: .center, content: {
                        Text("\(trainer.rating!.clean)")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.black)
                    })
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(trainer.experience!) year\( trainer.experience! > 1 ? "s" : "") experience")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(ColorConstant.luminousGreen)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .foregroundColor(.white)
            
            Spacer()
            
        } // end Main HStack
        .background(ColorConstant.gray)
        .clipShape(RoundedRectangle(cornerRadius: 20))  // Rounded corner
    }
}

//struct TrainerRow_Previews: PreviewProvider {
//    static var previews: some View {
//        TrainerRow()
//    }
//}
