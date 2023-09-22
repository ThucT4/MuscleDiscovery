//
//  FoodRowView.swift
//  RMIT-Hackathon-Workout
//
//  Created by Minh Trương on 13/09/2023.
//

import SwiftUI

struct FoodRowView: View {
    var FoodItem: Food
    
    private var imageURL: URL {
        return URL(string: FoodItem.image)!
    }
    
    var body: some View {
        HStack(spacing: 40){
            AsyncImage(url: imageURL) {image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .padding(.leading, 10)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 80)
            .padding(.leading)
            
            VStack(alignment: .leading, spacing: 8){
                VStack(alignment: .leading){
                    Text(FoodItem.name)
                        .bold()
                    Text(Image(systemName: "figure.gymnastics"))
                        .font(.caption2)
                        .bold()
                    + Text("\(FoodItem.calo, specifier: "%.1f") kcal")
                        .font(.caption2)
                        .bold()
                }
                
                HStack(){
                    BadgeView(tags: FoodItem.tags)
                }
                
            }
            .padding(.trailing, 10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 12)
        .background(Color("Dark grey"))
        .cornerRadius(20)
    }
}

